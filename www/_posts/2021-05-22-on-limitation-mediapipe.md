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
<style>
/* Three image containers (use 25% for four, and 50% for two, etc) */
.column {
  float: left;
  width: 33.33%;
  padding: 5px;
}

/* Clear floats after image containers */
.row::after {
  content: "";
  clear: both;
  display: table;
}
</style>

![](/assets/img/annotated_image1.png)
_[Source 1](https://www.neowin.net/news/microsoft-sets-a-new-world-record-for-most-people-in-a-selfie/), [Source 2](https://github.com/peiyunh/tiny/blob/master/data/demo/selfie.jpg), **Credit: Microsoft**_

Google AI announced MediaPipe Holistic [1] as a simultaneous face, hand, and pose inference engine for on-device AI.
As we knew, on-device AI works in a specialized environment such as Edge devices (Arduino, Raspberry Pi, Jetson Nano) and mobile devices (Android/iOS/...).
These environments are characterized by limited computing power (except Jetson Nano, all are low-end CPUs), often no Internet (wifi modules maybe not embedded).
Then MediaPipe is a great offer.
It provides a consistent interface for working with deep learning models and computer vision models in various programming languages (Java, Swift, Python, Javascript, ...).
The solution is also end-to-end, so the code can be done by calling ready-to-use functions. __But wait, such a big deal?__
This post provides a fairer view of the MediaPipe library for on-device face detection.
__The result is that, although MediaPipe is fast, however, the accuracy is limited for crowded scenes.__
__It works best when there is only one person in the frame.__
<!--more-->

## Lesson 1: MediaPipe works poorly in multi-faces scenario

Let's start with the famous selfie photo made by Microsoft Lumina 730. 

![](https://raw.githubusercontent.com/wanted2/mediapipe-multi-faces/main/selfie.jpg)

My code is as follows.

```python
import cv2
import mediapipe as mp
from time import time
file_list = ['selfie.jpg', 'selfie-3.jpg', 'selfie-small.jpg']
mp_face_detection = mp.solutions.face_detection
mp_drawing = mp.solutions.drawing_utils

# For static images:
with mp_face_detection.FaceDetection(
    min_detection_confidence=0.5) as face_detection:
  for idx, file in enumerate(file_list):
    print(f'Processing {file} ...')
    image = cv2.imread(file)
    # Convert the BGR image to RGB and process it with MediaPipe Face Detection.
    t1 = time()
    results = face_detection.process(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
    t2 = time()
    print(f'Processed {file} in {t2-t1:.5f} second(s)')

    # Draw face detections of each face.
    if not results.detections:
      continue
    annotated_image = image.copy()
    for detection in results.detections:
      print('Nose tip:')
      print(mp_face_detection.get_key_point(
          detection, mp_face_detection.FaceKeyPoint.NOSE_TIP))
      mp_drawing.draw_detection(annotated_image, detection)
    cv2.imwrite('./annotated_image' + str(idx) + '.png', annotated_image)
```
I downloaded the selfie photo and named it `selfie.jpg`.
Since I speculated that MediaPipe does not work in such a scenario (More than 1,000 faces in one photo), I cropped two different versions: one with less than 100 faces (`selfie-small.jpg`) and one with only 3 big faces (`selfie-3.jpg`).

<div class="row">
  <div class="column">
    <img src="https://raw.githubusercontent.com/wanted2/mediapipe-multi-faces/main/selfie.jpg" alt="Snow" style="width:100%">
    <p>Original photo</p>
  </div>
  <div class="column">
    <img src="https://raw.githubusercontent.com/wanted2/mediapipe-multi-faces/main/selfie-small.jpg" alt="Forest" style="width:100%">
    <p>Cropped image with less than 100 faces</p>
  </div>
  <div class="column">
    <img src="https://raw.githubusercontent.com/wanted2/mediapipe-multi-faces/main/selfie-3.jpg" alt="Mountains" style="width:100%">
    <p>Cropped image with 3 big faces</p>
  </div>
</div>
Results is as follows.

```text
python run_mediapipe.py
Processing selfie.jpg ...
INFO: Created TensorFlow Lite XNNPACK delegate for CPU.
INFO: Replacing 162 node(s) with delegate (TfLiteXNNPackDelegate) node, yielding 2 partitions.
Processed selfie.jpg in 0.02069 second(s)
Processing selfie-3.jpg ...
Processed selfie-3.jpg in 0.00496 second(s)
Nose tip:
x: 0.62226236
y: 0.37454954

Nose tip:
x: 0.23528881
y: 0.65063083

Nose tip:
x: 0.43768775
y: 0.32625142

Processing selfie-small.jpg ...
Processed selfie-small.jpg in 0.00852 second(s)
```

What this means is that, MediaPipe did not detect any faces in the original scenario (1,000 faces) and second scenario (about 100 faces).
But when there are 3 big faces, the result is promising (no miss in the 3 faces I wanted to detect).
![](/assets/img/annotated_image1.png)


Then for on-device AI, we cannot expect too much.
The limits of them which I obtained from this example:

* **Miss all faces in crowded scenes**.

* **Miss all small faces**: even with `selfie-3.jpg`, only big faces (area is more than 10% of the whole image) can be detected well.
Other small faces are missed.

With low budgets, we cannot expect too much.

One bright side of MediaPipe from this result is that __because small faces are often missed, then false positives (hi-jackers) is not a serious problem__.
For critical applications such as face authentication, making wrong decisions (false positives) can lead to hi-jackers/spoofers getting in the system, but if MediaPipe misses too many small faces, our hi-jackers are omitted __hopefully__ in return.

## Lesson 2: MediaPipe is fast

For the original image, MediaPipe took about 20 ms on average.
For the small image (100 faces), it took about 10-15 ms.
And for the smallest image, it took about 7-8 ms.

Since MediaPipe is not good at crowded scenes, then we can speculate that it is used in scenarios with a few faces.
In such scenarios, then 7-8ms/image, or 125 FPS is not bad.

## Conclusion
MediaPipe is fast but works poorly in crowded scenes.
From this observation, one recommendation is to only use it in one-person or few-people scenarios.

The source code can be found at my [Github](https://github.com/wanted2/mediapipe-multi-faces).


## References

{% bibliography --file mediapipe %}