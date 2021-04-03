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

Amazon Web Services Lambda [1] as a convenient serverless building block, can have hidden power.
Surprisingly, it seems like that there is no official document explaining what should be a good Lambda function for a programming language.
Except the facts that there is a limit of 5 Megabytes on the size of a uncompressed Lambda function, and 250 megabytes for all custom Lambda layers.
Furthermore, parallelism can be limited with some supports to AVX2 [2] and multiprocessing [3].
So anything can be implemented in Lambda, should we try to put a `cumbersome` architecture on it?
This is an open question and this post is to explore a possible answer.
<!--more-->

## Introduction

### Purpose: Finding a new design

Managed services like Amazon Sagemaker [4] provides a consistent and powerful platform to train and deploy machine learning models.
Another managed service is AWS Lambda [1] can serve as the intergration to API Gateway, which handles and responds to customer requests, upon connections to other services.
It seems like to be a natural way to put a simple and stupid function in Lambda's handler bodies.
But it also seems like that there is no such enforcement that the complexity of handler body is limited.
In another word, we can put anything inside it, and pay-as-we-go.

Then, (training ML models can take time and we do not put them in AWS), but can we put a cumbersome ML inference system in Lambda and serving requests?
In another word, if we have 2 different usages for Lambda:

* **Design 1**: using Lambda as a `reception` and call SageMaker or Textract, Comprehend for inference.
* **Design 2**: using Lambda custom layers to put the whole ML inference system in it and don't call to other services for inference. The inference is done in Lambda only.

Then we knew Design 1 is a normal usage, is Design 2 a recommended way?

### Setting up a script

We already had a purpose, now we need a script to implement.
The script is simplistic: we choose a cumbersome system in a ML task, deploy it to AWS Lambda and measure the gain.

**The ML tasks** are Named Entity Recognition (NER, [5,6]) and Context-based Question Answering (QA).
We choose them because they are complex enough and pretrained models are ready.
NER is a problem in the field of information extraction that which looks at identifying atomic elements (entities) in text and classifying them into predefined classes such as person names, organizations, locations, dates, .etc.
Approaches can be using lexicons, sliding windows and sequential models (Hidden Markov Models and Conditional Random Fields).
The input text is segemented into pieces of words (`tokens`) and a custom model classifies these token into predefined classes.
Tokenizers can be whitespace-based tokenizer or a language-independent data-driven approach like SentencePiece [7,8,9].
SentencePiece [7] implements subword regularization [8, 9].
Context-based Question Answering is the task to giving the answer to a question based on a context text.
The answer must be a part of the context.
Therefore, the answer can be returned as `[start_position, length]`.
A typical benchmark is the Standford SquAD dataset [10].
However, we will not train any model here, but use state-of-the-art model ALBERT [11] for inference.

**The cumbersome systems/models** are spaCy [12] and mxnet [13,14] based BERT models [11,15,16].
spaCy is a ready-to-use Python library for liguistics tasks like NER, PoS tagging.
Pipelines are execution units in spaCy to chaining several different components such as tokenizers, ner, pos taggers, .etc.
Apache mxnet is a flexible and efficiency library for Deep Learning.
Hence, the size of each of spaCy and mxnet is about 250 megabytes.
The total size is about 500 megabytes, therefore we need to separate into 2 Lambdas.

**Serverless Architecture Model (SAM, [17])** is used to deploy to Lambda.
We test and measure, monitor the gain directly in AWS Lambda Web interface.

## spaCy, Apache mxnet, AWS Lambda, and BERT

## Discussion

## Reference

{% bibliography --file lambda-complex %}