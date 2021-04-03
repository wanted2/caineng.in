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
It seems that it is a natural way to put a simple and stupid function in Lambda's handler bodies.
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
Pipelines are execution units in spaCy to chain several different components such as tokenizers, ner, pos taggers, .etc.
Apache mxnet is a flexible and efficient library for Deep Learning.
Hence, the size of each library is about 250 megabytes.
Because the total size is about 500 megabytes, we need to separate it into 2 Lambdas.

**Serverless Architecture Model (SAM, [17])** is used to deploy to Lambda.
We test and measure, monitor the gain directly in the AWS Lambda Web interface.

## Implementations

### NER in Lambda

We run a spaCy pipeline in Lambda to respond to a batch of sentences.
The default pipeline is as follows:

![](https://spacy.io/pipeline-fde48da9b43661abcdf62ab70a546d71.svg)

Besides the entity information, it also returns PoS tags in the output `Doc`.


### QA in Lambda

## Discussion

## Reference

{% bibliography --file lambda-complex %}