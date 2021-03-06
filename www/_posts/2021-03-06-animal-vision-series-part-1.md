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
| Farming Management | Livestock Management | Automatic counting of animals in the farms help the farmers better manage their hounds and when an individual have a dieasea, AI-enabled system can alert the farmers to separate the dieasea one from the rest. | Animal counting, density estimation, image anomaly detection, UAV/Drones, object detection/classification/segmentation |

## References

{% bibliography --file aniv %}