---
layout: post
title: "Implementing a complex system in AWS Lambda: Should or shouldn't?"
excerpt_separator: "<!--more-->"
categories:
  - sre
  - ai
tags:
  - nlp
  - natural language processing
  - site reliability engineering
  - spacy
  - mxnet
  - albert
  - bert
  - gluon
  - gluon-nlp
toc: true
---

![](/assets/img/mxnet.png)

Amazon Web Services Lambda [1] is a convenient serverless building block, can have hidden power.
Surprisingly, it seems like that there is no official document explaining what should be a good Lambda function for a programming language.
The size of an uncompressed Lambda function does not exceed 5 megabytes, and the size for all custom Lambda layers should not exceed 250 megabytes.
Furthermore, parallelism can be limited with some supports to AVX2 [2] and multiprocessing [3].
Although anything can be implemented in Lambda, should we try to put a `cumbersome` architecture on it?
It is an open question, and this post is to explore a possible answer.
<!--more-->

## Introduction

### Purpose: Finding a new design

Managed services like Amazon Sagemaker [4] provides a consistent and powerful platform to train and deploy machine learning models.
Another managed service is AWS Lambda [1] can serve as the integration to API Gateway, which handles and responds to requests upon connections to other services.
It seems that it is a natural way to put a simplistic function in Lambda's handler bodies.
But it also seems like there is no such enforcement for the complexity of the bodies.
In other words, we can put anything in them and pay-as-we-go.

Then, (training ML models can take time, and we do not put them in AWS), but can we put a cumbersome ML inference system in Lambda and serving requests?
In other words, we have 2 different usages for Lambda:

* **Design 1**: using Lambda as a `reception` and call SageMaker or Textract, Comprehend for inference.
* **Design 2**: using Lambda custom layers to put the whole ML inference system in it and don't call to other services for inference. The inference is in Lambda only.

Then we knew that Design 1 is usual.
Is Design 2 a recommended way?

### Setting up a script

We already had a purpose, and we need a script to implement.
The script is simplistic: we choose a cumbersome system in a machine learning task, deploy it to AWS Lambda and measure the gain.

**The ML tasks** are Named Entity Recognition (NER, [5,6]) and Context-based Question Answering (QA).
We choose them because they are complex enough and pre-trained models are ready.
NER is a problem in information extraction that looks at identifying atomic elements (entities) in text and classifying them into predefined classes such as person names, organizations, locations, dates, .etc.
Approaches can be using lexicons, sliding windows, and sequential models (Hidden Markov Models and Conditional Random Fields).
The input text is segmented into pieces of words (`tokens`), then a custom model classifies these token into predefined classes.
Tokenizers can be whitespace-based tokenizers or a language-independent data-driven approach like SentencePiece [7,8,9].
SentencePiece [7] implements subword regularization [8, 9].
Context-based Question Answering is the task of answering a question based on a context text.
The answer must be a part of the context.
Therefore, the answer can be returned as `[start_position, length]`.
A typical benchmark is the Standford SquAD dataset [10].
However, we don't train models but do use state-of-the-art model ALBERT [11] for inference.

**The cumbersome systems/models** are spaCy [12] and mxnet [13,14] based BERT models [11,15,16].
spaCy is a ready-to-use Python library for linguistics tasks like NER, PoS tagging.
Pipelines are units in spaCy to chain several different components such as tokenizers, ner, pos taggers, .etc.
Apache mxnet is a flexible and efficient library for Deep Learning.
Hence, the size of each library is about 250 megabytes.
Because the total size is about 500 megabytes, we need to separate it into 2 Lambdas.

**Serverless Architecture Model (SAM, [17])** is used to deploy to Lambda.
We test and measure, monitor the gain directly in the AWS Lambda Web interface.

## Implementations

### NER in Lambda

#### The handler
We run a spaCy pipeline in Lambda to respond to a batch of sentences.
Pipelines in spaCy are reliable and stable processing units.
The default pipeline is as follows:

![](https://spacy.io/pipeline-fde48da9b43661abcdf62ab70a546d71.svg)
_Figure 1. spaCy's default pipeline (source: [spaCy](https://spacy.io/usage/processing-pipelines))_

Besides the entity information, it also returns PoS tags in the output `Doc`.
We can use the pipeline in Python:

```python
import spacy

# Load default pipeline for linguistic task
nlp = spacy.load('en_core_web_sm')
```

And the handler function is:

```python
def lambda_handler(event, context):
    """Lambda function to process linguistic tasks

    Parameters
    ----------
    event: dict, required
        API Gateway Lambda Proxy Input Format

        Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format

    context: object, required
        Lambda Context runtime methods and attributes

        Context doc: https://docs.aws.amazon.com/lambda/latest/dg/python-context-object.html

    Returns
    ------
    API Gateway Lambda Proxy Output Format: dict

        Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
    """

    assert "body" in event, "Event is not coming from API Gateway"
    try:
        data = json.loads(event["body"])
    except json.JSONDecodeError as e:
        logger.error(e)
        return respond(Exception("JSON data problem"), None)
    except BaseException as e:
        logger.error(e)
        return respond(Exception("JSON data problem"), None)

    try:
        batch_data = data['batch']
    except KeyError as e:
        logger.error(e)
        return respond(Exception("You must submit a batch data"))
    if not isinstance(batch_data, list):
        return respond(Exception("Batch data must be a list"), None)
    nb = len(batch_data)
    if nb < 100 or nb > 300:
        return respond(Exception("Batch size should be between 100 and 300 for trade-off between efficiency and waiting time"), None)
    logger.info("Processing a batch of {} sentences".format(nb))
    docs = []
    failed_sentences = []
    for sentence in batch_data:
        try:
            doc = nlp(sentence)
            docs.append(doc.to_json())
        except BaseException as e:
            logger.error(e)
            failed_sentences.append(sentence)
            continue
    logger.debug(failed_sentences)
    return respond(None, body={
        "success_sentences": docs,
        "failed_sentences": failed_sentences
    })
```
We remark the economy of Lambda business.
Concurrency [18] can provide up to 10000 Lambda processes running at a time, and Amazon makes money by charging on this use by requests and by GB-seconds.
Each time a concurrent Lambda runs, the bootstrap runs again.
For example, the line `nlp = spacy.load('en_core_web_sm')` runs every time invoking a concurrent Lambda.
Therefore, using a large batch size, we gain the time of reloading the `nlp` indeed.
However, a too large batch size (over 300 sentences) can lead to long service time.
It reduces the quality of the service and user experiences.
We choose a batch size between 100 and 300.

#### Custom Lambda Layers

spaCy is not installed in AWS Lambda runtime environments.
Therefore, we need to add a custom Lambda layer with the spaCy library.
Currently, AWS Lamda runtime uses `python3.7`.
We must use Docker to build spaCy in an Amazon Linux container and zip the `site-packages` folder.
A sample Dockerfile:

```dockerfile
FROM amazonlinux:2.0.20210219.0

RUN yum update -y
RUN yum install -y python3-devel python3-setuptools python3-wheel git gcc gcc-c++ libatlas-devel
RUN mkdir -p /packages/python/lib/python3.7/site-packages
RUN pip3 install -U numpy Cython
RUN pip3 install -U numpy Cython -t /packages/python/lib/python3.7/site-packages
RUN pip3 install -U cymem
RUN pip3 install -U cymem -t /packages/python/lib/python3.7/site-packages
RUN pip3 install -U murmurhash preshed
RUN pip3 install -U murmurhash preshed -t /packages/python/lib/python3.7/site-packages
RUN BLIS_REALLY_COMPILE=1 BLIS_ARCH=generic pip3 install -U blis
RUN BLIS_REALLY_COMPILE=1 BLIS_ARCH=generic pip3 install -U blis -t /packages/python/lib/python3.7/site-packages
RUN pip3 install -U thinc
RUN pip3 install -U thinc -t /packages/python/lib/python3.7/site-packages
RUN pip3 install -U spacy
RUN pip3 install -U spacy -t /packages/python/lib/python3.7/site-packages
RUN python3 -m spacy download en_core_web_sm
RUN python3 -m spacy download ja_core_news_sm
RUN pip3 install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-3.0.0/en_core_web_sm-3.0.0.tar.gz -t /packages/python/lib/python3.7/site-packages/
RUN mkdir -p /packages2/python/lib/python3.7/site-packages
RUN pip3 install https://github.com/explosion/spacy-models/releases/download/ja_core_news_sm-3.0.0/ja_core_news_sm-3.0.0.tar.gz -t /packages2/python/lib/python3.7/site-packages/

WORKDIR /packages
RUN zip -r spacy-py37.zip python

WORKDIR /packages2
RUN zip -r spacy-ja-py37.zip python
```
Note, only `spacy-py37.zip` has nearly 250 megabytes when uncompressed.


### QA in Lambda

#### Task QA
Given the context, the machine looks for a part of the given context which answers the question.
A sample triplet is as follows:

```text
Context:
The Norman dynasty had a major political, cultural and military impact on medieval Europe and even the Near East. The Normans were famed for their martial spirit and eventually for their Christian piety, becoming exponents of the Catholic orthodoxy into which they assimilated. They adopted the Gallo-Romance language of the Frankish land they settled, their dialect becoming known as Norman, Normaund or Norman French, an important literary language. The Duchy of Normandy, which they formed by treaty with the French crown, was a great fief of medieval France, and under Richard I of Normandy was forged into a cohesive and formidable principality in feudal tenure. The Normans are noted both for their culture, such as their unique Romanesque architecture and musical traditions, and for their significant military accomplishments and innovations. Norman adventurers founded the Kingdom of Sicily under Roger II after conquering southern Italy on the Saracens and Byzantines, and an expedition on behalf of their duke, William the Conqueror, led to the Norman conquest of England at the Battle of Hastings in 1066. Norman cultural and military influence spread from these new European centres to the Crusader states of the Near East, where their prince Bohemond I founded the Principality of Antioch in the Levant, to Scotland and Wales in Great Britain, to Ireland, and to the coasts of north Africa and the Canary Islands.

Question: Who was the duke in the battle of Hastings?
Answer: William the Conqueror
```
#### The handler
We pay attention to the BERT Transformer architecture [15,16].
BERT representations have been trained in several pretext tasks [19].

![](/assets/img/bert.svg)
_Figure 2. BERT architecture_

The input of BERT models is a pair of `(question, context)` with a series of 0s and 1s representing the token types(question or context?), and the output is a triplet $(S,E,A)$.
We formulate the probability of finding a triplet output given the contextual embedding as
$$P(S, E, A | C) = P(S | C)\times P(E | S,C)\times P(A | C) $$
where $C$ is the contextual embedding vector, $S$ is the start position of the answer in the context, $E$ is the end position, and $A$ is the answerable decision to the question.
In the inference, $P(S|C)$ is modeled as the log-softmax of contextual embedding logits.
$P(E|S,C)$ is the log-softmax of concatenated features between contextual embeddings and start features.
$P(A|C)$ is computed using a feed-forward neural network and log-softmax.
The beam search is then applied in the computed score $P(S,E,A|C)$ to find the best candidates for an answer.
ALBERT [11] is a lightweight successor of BERT.
The inference code is almost similar.

#### Custom Lambda Layer

While mxnet library itself is small and takes nearly 250 megabytes, adding Gluon-NLP makes the size is over the limit.
Therefore, while building mxnet in a custom layer, we put `gluon-nlp` code into a Lambda function.

### SAM template

The template for the Lambdas can be found at [https://github.com/wanted2/aws-sam-spacy-mxnet-bert-puppy-talk-example](https://github.com/wanted2/aws-sam-spacy-mxnet-bert-puppy-talk-example).

## Discussion

### Runtime
We tested in Lambda and observed that

* __Spacy function__: for a batch of 100 sentences, it took 5.7 seconds. For a batch of 500 sentences, it took 28.7 seconds. Therefore, we set the timeout to 30 seconds and recommend users to send batches with less than 300 items. 

* __Multiprocessing__:
There is a good guideline about multiprocessing in AWS Lambda:
https://aws.amazon.com/jp/blogs/compute/parallel-processing-in-python-with-aws-lambda/
I created the code (following the above article) to see if multiprocessing can help.
__Unfortunately, multiprocessing does not help ;)__
For a batch of 100 sentences, it took 15.5s, 3x slower than sequential processing.

### Memory
A memory budget 256MB was enough for spaCy.
The budget for mxnet inference is 4GB.

## Conclusion

Some lessons we learned from this implementation:

* __Simplicity is the best design__: adding custom Lambda layers requires going through the hurdle of building too many unexpected things such as custom library distributions for specific architecture and operating systems (amazon linux), adjusting the size to match the policy of Lambda, .etc.
* __Don't think you can do whatever you want with Lambda__. By bypassing the size restrictions of Lambda code, indeed, we are `hacking` AWS in some senses. Then this is a bad design! The company made the restriction and the design of Lambda to protect their business models (maybe), and we are hacking them for more performance! :D That's the whole picture of what we were doing.
* __Design 2 is for hackers, then Design 1 is for usual developers__.

In this post, we only considered two designs with all components are in the AWS Cloud.
In practice, the systems may have components not in the cloud, and that makes the game is far interesting.

## Reference

{% bibliography --file lambda-complex %}