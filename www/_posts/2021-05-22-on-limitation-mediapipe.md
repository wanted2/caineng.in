---
layout: post
title: "On Limitation of MediaPipe Holistic Face Detection Module"
excerpt_separator: "<!--more-->"
categories:
  - cv
  - ai
tags:
  - on-device AI
  - face detection
  - mediapipe
  - google ai
  - google
toc: true
---

![](/assets/img/annotated_image1.png)
_[Source 1](https://www.neowin.net/news/microsoft-sets-a-new-world-record-for-most-people-in-a-selfie/), [Source 2](https://github.com/peiyunh/tiny/blob/master/data/demo/selfie.jpg), **Credit: Microsoft**_

Google AI announced MediaPipe Holistic [1] as a simultaneous face, hand and pose inference engine for on-device AI.
As we knew, on-device AI works in a specialized environment such as Edge devices (Arduino, Raspberry Pi, Jetson Nano) and mobile devices (Android/iOS/...).
These enviroments are characterised with limited computing power (except Jetson Nano, all are low-end CPUs), often no Internet (wifi modules may be not embedded).
Then MediaPipe is a great offer.
It provides a consistent interface for working with deep learning models and computer vision models in various programming language.
The soultion is also end-to-end, so the code can be done by calling ready-to-use functions. __But wait, such a big deal?__
This post will provide a fairer view of the MediaPipe library for on-device face detection.
The result is that, although MediaPipe is fast but the accuracy is limited for crowded scenes.
It works best when there is only one person in the frame.

## References

{% bibliography --file mediapipe %}