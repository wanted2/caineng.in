---
layout: post
title: "Animal Vision Part 1: Course Introduction"
excerpt_separator: "<!--more-->"
categories:
  - cv
  - ai
tags:
  - ai
  - animal vision
  - computer vision
  - artificial intelligence
  - image processing
---

![](/assets/img/dogs.PNG)

The purpose of this `learning-by-doing` course is to get familiar with a cross-discipline topic: Computer Vision for Agriculture.
Specifically, we introduce Animal Vision (AniV), targeting canine animals.
Learners get through several useful applications of Computer Vision (CV) into Animal Farming:

* Object Recognition, Detection and Segmentation (including class, instance and panoptic segmentation [1])
* Methods to adapt to new domains in farming such as Transfer Learning and Domain Adaptation.
* Image enhancement methods such as de-raining, super-resolution, .etc.
* Applications such as Dog counting, animal crowd density estimation, anomaly detection.
The objective of this course is to build a proper Animal Vision system below.

<!--more-->

## Introduction

__Automation__ is changing the world with growing conventional technologies such as Information Tech, Software, Hardware, and frontier domains such as Artificial Intelligence (AI), Machine Learning (ML), Deep Learning (DL), Internet of Things (IoT), Computational Linguistics (CL), and Computer Vision (CV).
Cloud platforms like Amazon Web Services (AWS) provides convenient solutions to handle many industrial problems at hand, such as Equipment Defect Detection using _AWS Lookout for Equipment [2]_.
For Agriculture Automation, the uses of CV are also growing [3, 4] in two sectors in agriculture: crops and farming.

| Applications | Sub-tasks | Description | Technologies |
|-|-|-|-|
| Crop Management | Crop Monitoring | AI engine mounted into a UAV can detect crops and monitor their growth for human diagnostic. Human experts and farmers can perform further investigations and change the plan of feeding crops. | UAV/Drones, object detection/classification/segmentation |
|  | Yield Prediction | Using deep learning with satellite imagery, we can gather various information like soil conditions, nitrogen levels, moisture, seasonal weather, historical yield information of crops for precise farming.  | Time series forecasting, fruit object counting |
| Food Safety | Environment Management | From historical information of crop environment, such as soil conditions, nitrogen levels, moisture, seasonal weather, spotting the outliers to judge the quality of the crops and fruits.   | Time series anomaly detection |
|  | Spraying pesticides | We use AI-enabled drones to monitor the infected crops and spray the pesticides to prevent crops from insects and pests. The computer vision allows drones to precisely detect the infected crops and spray the pesticides accordingly. | Image anomaly detection, UAV/Drones, object detection/classification/segmentation |
|  | Automatic quality grading and sorting | Using the deep learning techniques, we calculate the percentage of infection. The grading and sorting of the fruit image helping farmers to reduce the crop damages due to storage. | Image classification, image anomaly detection, object detection/classification/segmentation |
|  | Weight estimation | CV enables automatic weight detection to ensure that animals grow well before being sent to the slaughterhouse.  | Image weight estimation, UAV/Drones, object detection/classification/segmentation |
| Farming Management | Livestock Management | Automatic counting of animals in the farms helps the farmers better manage their hounds. When an individual has a sickness, the AI-enabled system can alert the farmers to separate the sick ones from the rest. | Animal counting, density estimation, image anomaly detection, UAV/Drones, object detection/classification/segmentation |

The applications in this field include Forestry Management, which is similar to Crop Management but has some other issues such as burning prevention.
Our targets include Farming Management (and weight estimation).

## System

### A system for farming management

![](/assets/img/farm.png)

1. A camera captures an image and sends it to the server. In the server, a __Global Anomaly Detector (GAD)__ detects whether if there is a non-targeted class in the image. For example, if the monitor scenario only accepts dogs and sheep, the system must raise an alert (5) when a wolf or a human thief appears.

2. If GAD detects only accepted classes, (4) a __1-class detector/segmentation model__ (or __limited-domain model, LDM__) detects the (7) __annotations (bounding boxes and polygons)__. Here, we find other benefits of GAD: it reduces the __load and mistakes of LDM__. __Why?__ Because in the course, we see that 1-class models and 1-vs-rest learning mechanisms often result in __over-confidence problem__: the 1-class model makes many false-positives (FPs) on the rest classes. Therefore, using a GAD reduces the chance of such over-confidence by __early detection of intrusions__.

3. For each detection of LDM, it is passed to a __wide-domain classifier (WDC)__ such as an ImageNet pre-trained model. GAD does early intrusion detection, WDC performs late detection of intrusions. Because a 1-class model can give many FPs, GAD is insufficient. Since WDC learned in 1000 classes, a larger knowledge base than LDM, it is less over-confident.
WDC firmly prevents non-target classes from being intruded into the Analytics Database.

4. If the detection surpasses RAD, it has less chance to be a false alarm. 
We want to obtain further analytics information: 
(10) __Regional Anomaly Detector (RAD)__ which finds if the instance region has sickness or not; 
(11) __Fine-Grained Classifier (FGC)__ returns the detailed classes such as breed names of the instances (an Egyptian dog rather than a dog); and 
(12) __Weight Estimation Model (WEM)__ returns the instance weight for further diagnostics.

5. The above information is inserted by timestamp to the Analytics Database to display in the Dashboard to the farm owners.

In this course, we learn the CV and ML technologies to implement this system.

### Technologies

#### Image classification

As said before, Global Anomaly Detector (GAD) for early intrusion detection, as well as the Wide-Domain Classifier for late intrusion detection, are implemented by Wide-domain models such as pre-trained ImageNet models. This technology is well known today, especially after 2012 with the boost of the Deep Learning era.

#### Object detection and segmentation
We apply these classes of technology to 1-class models and RAD models above.

#### Image Anomaly Detection
This technology aims at delivering the infected instances in an image.
The deliverables can be bounding boxes, polygons, or binary labels (sickness/noon-sickness).
GAD and RAD use this technology. __Gathering training data__ can be a problem due to the frequency of rare events.

#### Machine Learning

Data augmentation, balancing training data, domain adaptation, and transfer learning can be the core set of ML technologies we need to learn.

#### Image Processing

Some worst cases in practice require further care about image quality:

* __Bad weather__ such as raining and snowing can result in low detection quality. De-raining models can be useful.
* __Camera movement__ can be complement by calibration.
* __Low-resolution imagery__ requires up-scaling or super-resolution.

The models can be run on the input images before fed to GAD.

#### Attribute Detection

For farming, they feed most animal breeds for meat.
Therefore, attributes which affect the quality of food are inevitable.
They are animal health conditions such as weight and sickness.


#### Fine-Grained Categorization

FGC helps to identify the breeds and origins of the animals.
This technology contributes to quality insurance to keep traceability of food origin.

## About this course

In this course, we implement the Animal Vision System (AVS) using frontier technologies.

### Tools

| Language | English |
| OS | Ubuntu, macOS, Windows x64 |
| Programming Language | Python (C/C++) |
| Deep Learning frameworks | PyTorch |
| Computer Vision and Machine Learning libraries |  `opencv-contrib-python, scikit-learn, scipy, scikit-image` |

### Posts

1. [x] __Introduction (this post)__
2. [ ] __Introduction about Computer Vision (using `scikit-image` and `opencv`)__
  - Image filters, edge detection, calibration, artifact removals, .etc.
3. [ ] __Object detection, classification and segmentation__
  - Image features
  - Conventional object detection methods like the Viola-Jones cascade method.
  - Convolutional neural networks, convolutional/pooling/upscaling/dilated operations, etc.
4. [ ] __Advanced problems in image enhancement (1)__
  - Generative Adversarial Networks, Auto-Encoders
5. [ ] __Advanced problems in image enhancement (2)__
  - Haze removal, artifact removal, reconstruction
  - Super-resolution, de-raining methods.
6. [ ] __Machine learning (1)__
  - The role of data augmentation
  - Common learning problems: over-fitting/under-fitting
  - Over-confidence problems: Open-world recognition
7. [ ] __Machine learning (2)__
  - Learning in new domains
  - Transfer learning vs. Domain Adaptation
8. [ ] __Machine learning (3)__
  - One-vs-rest learning
  - Limited-domain learners (experts) vs. Wide-domain learners (generalists) and over-confidence problems.
9. [ ] __Machine learning (4)__
  - Anomaly Detection
10. [ ] __Animal Vision (1)__
  - Object counting
  - Density Estimation
11. [ ] __Animal Vision (2)__
  - Attribute detection: weight estimation and anomalous individual detection
12. [ ] __Conclusion__
  - The whole system

## References

{% bibliography --file aniv %}