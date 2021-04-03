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
Suprisingly, it seems like that there is no official document explaining what should be a good Lambda function for a programming language.
Except the facts that there is a limit of 5 Megabytes on the size of a uncompressed Lambda function, and 250 megabytes for all custom Lambda layers.
Furthermore, parallelism can be limited with some supports to AVX2 [2] and multiprocessing [3].
So anything can be implemented in Lambda, should we try to put a `cumbersome` architecture on it?
This is an open question and this post is to explore a possible answer.
<!--more-->

## Introduction

### Purpose: Finding a new design

Managed services like Amazon Sagemaker [4] provides a consistent and powerful platform to train and deploy machine learning models.
Another managed service is AWS Lambda [1] can serve as the intergration to API Gateway, which handle and respond to customer requests, upon connections to other services.
It seems like to be a natural way to put a simple and stupid function in Lambda's handler bodies.
But it also seems like that there is no such enforcement that the complexity of handler body is limited.
In another word, we can put anything inside it, and pay-as-we-go.

Then, (training ML models can take time and we do not put them in AWS), but can we put a cumbersome ML inference system in Lambda and serving requests?
In another word, if we have 2 different usages for Lambda:

* **Design 1**: using Lambda as a `reception` and call SageMaker or Textract, Comprehend for inference.
* **Design 2**: using Lambda custom layers to put the whole ML inference system in it and don't call to other services for inference. The inference is done in Lambda only.

Then we know Design 1 is a normal useage, is Design 2 a recommended way?

### Setting up a script

## spaCy, Apache mxnet, AWS Lambda, and BERT

## Discussion

## Reference

{% bibliography --file lambda-complex %}