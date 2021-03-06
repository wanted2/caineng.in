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
Specificially, we will introduce Animal Vision (AniV), targeting on canine animals.
Learners will get through several useful applications of Computer Vision (CV) into Animal Farming:

* Object Recognition, Detection and Segmentation (including class, instance and panoptic segmentation [1])
* Methods to adapt to new domains in farming such as Transfer Learning and Domain Adaptation.
* Image enhancement methods such as de-raining, super-resolution, .etc.
* Applications such as Dog counting, animal crowd density estimation, anomaly detection.

<!--more-->

## Introduction

__Automation__ is changing the world with growing conventional technologies such as Information Tech, Software, Hardware, .etc. and frontier domains such as Artificial Intelligence (AI), Machine Learning (ML), Deep Learning (DL), Internet of Things (IoT), Computational Linguistic (CL), and Computer Vision (CV).
Cloud platforms like Amazon Web Services (AWS) provides convenient solutions to handle many industrial problems at hands, such as Equipment Defect Detection using _AWS Lookout for Equipment [2]_.
For Agriculture Automation, the uses of CV is also growing [3, 4], in two major sectors in agriculture: crops and farming.

| Applications | Sub-tasks | Description | Technologies |
|-|-|-|-|
| Crop Management | Crop Monitoring | AI engine which is mounted on an UAV can detect crops and monitor their growth for human diagnostic. Human experts and farmers can perform their further investigations and change the plan of feeding crops. | UAV/Drones, object detection/classification/segmentation |
|  | Yield Prediction | Deep learning with the help of satellite imagery, various information can be gathered like soil conditions, nitrogen levels, moisture, seasonal weather and historical yield information of crops for precise farming.  | Time series forecasting, fruit object counting |
| Food Safety | Environment Management | From historical information of crop environment, such as soil conditions, nitrogen levels, moisture, seasonal weather, spotting the outliers to judge the quality of the crops and fruits.   | Time series anomaly detection |
|  | Spraying pesticides | The AI-enabled drones are capable to monitor the infected crops and spray the pesticides to prevent crops from insects and pests. The computer vision allows drones to precisely detect the infected crops and spray the pesticides accordingly. | Image anomaly detection, UAV/Drones, object detection/classification/segmentation |
|  | Automatic quality grading and sorting | Using the deep learning techniques once the percentage of infection is calculated then on the basis of percentage do the grading and sorting of the fruit image helping farmers to reduce the crop damages due to storage. | Image classification, image anomaly detection, object detection/classification/segmentation |
|  | Weight estimation | CV enables automatic weight detection to ensure that animals grow well before being sent to the slaughterhouse.  | Image weight estimation, UAV/Drones, object detection/classification/segmentation |
| Farming Management | Livestock Management | Automatic counting of animals in the farms help the farmers better manage their hounds and when an individual have a disease, AI-enabled system can alert the farmers to separate the disease one from the rest. | Animal counting, density estimation, image anomaly detection, UAV/Drones, object detection/classification/segmentation |

The applications in this field include Forestry Management, which is similar to Crop Management but has some other issues such as fire prevention.
Our targets include Farming Management (and weight estimation).

## System

### A system for farming management

![](/assets/img/farm.png)

1. A camera captures an image and sends it to the server. In the server, first a __Global Anomaly Detector (GAD)__ detects whether if there is a non-targeted class in the image. For example, if the monitor scenario only accepts dogs and sheeps, the system must raise an alert (5) when a wolf or a human thief appear.

2. If GAD detects only accepted classes, (4) a __1-class detector/segmentation model__ (or __limited-domain model, LDM__) will detect the (7) __annotations (bounding boxes and polygons)__. Here, we find other benefits of GAD: it reduces the __load and mistakes of LDM__. __Why?__ Because in the course, we will see that 1-class models and 1-vs-rest learning mechanisms often result in __over-confidence problem__: the 1-class model will make many false-positives (FPs) on the rest classes. Therefore, using a GAD reduces the chance of such over-confidences by __early detection of intrusions__.

3. For each detections of LDM, it will be passed to  a __wide-domain classifier (WDC)__ such as an ImageNet pretrained model. While GAD does early detection of intrusions, WDC performs late detection of instrusions. Because, 1-class model can give many FPs, GAD might be not enough. WDC learned in 1000 classes, therefore, it has a large knowledge base then LDM, thus, it is less over-confident.
WDC firmly prevents non-target classes from being intruded into the Analytics Database.

4. If the detection surpass RAD, it has less chance to be an false alarm. Now, further analytics can be applied. Analytics information we want to obtain are: (10) __Regional Anomaly Detector (RAD)__ which finds if the instance region has diease or not; (11) __Fine-Grained Classifier (FGC)__ returns the detailed classes such as breed names of the instances (an Egyptian dog rather than a dog); and (12) __Weight Estimation Model (WEM)__ returns the weight of the instance for further diagnostics.

5. The above information will be inserted by timestamp to the Analytics Database to display in the Dashboard to owner of the farm.

In this course, we will learn the CV and ML technologies to implement this system.

### Technologies

#### Image classification

As said, Global Anomaly Detector (GAD) for early intrusion detection, Wide-Domain Classifier for late intrusion detection can be implemented by Wide-domain models such as pretrained ImageNet models. This technology is well known today, especially after 2012 with the boost of new DL era.

#### Object detection and segmentation
These class of technology can be applied to 1-class models and RAD models above.

#### Image Anomaly Detection
This technology aims at delivering the infected instances in an image. The form of deliverables can be bounding boxes, polygons or just binary labels (diease/noon-diease).
GAD and RAD use this technology. __Gathering training data__ can be a problem due to the frequency of rare events.

#### Machine Learning

Data augmentation, balancing training data, domain adaptation and transfer learning can be the core set of ML technologies we need to care.

#### Image Processing

Some failure cases in practice requires further care about image quality:

* __Bad weather__ such as raining and snowing can result in poor detection quality. De-raining models can be useful.
* __Camera movement__ can be complement by calibration.
* __Low resolution__ requires up-scaling or super-resolution.

The models can be run on the input images before feding to GAD.

#### Attribute Detection

For farming, most animal breeds were being fed for meat.
Therefore, attributes which affect the quality of food like animal health conditions (weight and diease history) are important.


#### Fine-Grained Categorization

FGC helps to identify the breeds and origins of the animals.
This technoloogy contributes to quality ensurance to keep tracebility of food origin.


## References

{% bibliography --file aniv %}