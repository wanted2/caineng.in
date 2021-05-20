---
layout: post
title: "Understanding Object Detection Algorithms: the Non-maximum-supression (NMS)"
excerpt_separator: "<!--more-->"
categories:
  - cv
  - ai
tags:
  - computer vision
  - object detection
  - nms
  - non-maximum-suppression
toc: true
---

![](/assets/img/nms1.svg)

The non-maximum-suppression (NMS) is one of the most common parts of object detection methods.
The idea is to remove the overlapping bounding boxes and keep only the separated boxes in the detection result.
Given a threshold and starting from a particular box, any other boxes which have the overlappings with the reference larger than the threshold will be opted out.
The process is repeated until all boxes are visited.

<!--more-->

## Basic algorithms and speed-up

Let the threshold be $\theta=0.33$ and start from the red box.
Then we can remove the black and the blue ones because they have overlappings with the reference bigger than 0.33.
Here, we chose the overlap is the rate between intersection and union of the boxes.
It is illustrated as follows.

![](/assets/img/nms2.svg)

As illustrated above, if the reference box (green one) has more than $t$ of the area of the target box (black box), then the target box is _overlapped_ with the reference and that the target should be removed.


> **Algorithm parameters:** threshold  $\theta \in (0, 1]$    
> A list of detected bounding boxes $L$.
> 
> **Procedure $NMS(L, \theta)$:**
>
$\quad$1. Sort the box $L$, for example, by the bottom right coordinate values.   
$\quad$2. Initialize the picked boxes list $P\leftarrow \phi$   
$\quad$3. Loop until $L$ become empty:
>
$\qquad$3.1 Choose the last box in the sorted list, push the index to the picked indices $P$
>
$\qquad$3.2 Find all overlapping boxes with the reference (the last box in $L$), and remove all of them from the list $L$
>
$\qquad$3.3 Remove the reference box from $L$ 

To implement an efficient (fast) NMS, it is best to avoid using nested `for` loops.
For example, in some reference implementations, step `3.2` can be implemented as a `for` loop.
However, if we use `numpy` matrix operations such as `numpy.where` or `numpy.multiply`, we can perform faster the NMS.
An example is from [Adrian Rosebrock's implementation](https://www.pyimagesearch.com/2015/02/16/faster-non-maximum-suppression-python/) which resulted in a 100x faster NMS.

A careful implementation of NMS is ready to use is the [`tf.image.non_max_suppression`](https://www.tensorflow.org/api_docs/python/tf/image/non_max_suppression).
I also used it in the [inference of YOLOv5](https://github.com/wanted2/yolov5-tf-inference/blob/main/src/yolotf/utils.py#L226).

## Discussions

### Why sorting the boxes before running nms?

It is quite trivial, and often omitted issue in NMS.
Let's see the first example we explained.
What if we don't start from the red box but the black box?
What happens is as follows.

![](/assets/img/nms3.svg)

**The result has changed, according to the changes in the choice of the reference**.
Therefore, we need to sort the box list before running NMS.

### Should we prune low-confidence boxes before or after running NMS?

In my implementation of [inference of YOLOv5](https://github.com/wanted2/yolov5-tf-inference/blob/main/src/yolotf/utils.py#L226), I prune low-confidence boxes before NMS.
Because NMS takes time, prunning low-probability candidates beforehand is preferred.
After NMS, if the candidates is still too many, then we can merge boxes again using another overlapping measurements such as the IoU.

In this implementation, the NMS often takes about 10-20 ms to opt out some hundreds boxes.

## Conclusion

We discussed about the vital part of object detection to remove redundancies in detected results: the non-maximum-suppression algorithm.
To enhance the accuracy with NMS, some improvements such as the _Soft NMS_ [1] should be the idea.

## References

{% bibliography --file nms %}