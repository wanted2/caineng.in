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

## spaCy, Apache mxnet, AWS Lambda, and BERT

## Discussion

## Reference

{% bibliography --file lambda-complex %}