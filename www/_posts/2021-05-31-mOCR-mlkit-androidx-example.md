---
layout: post
title: "mOCR: A real-time application of OCR with Google MLKit and Android CameraX"
excerpt_separator: "<!--more-->"
categories:
  - cv
  - ai
tags:
  - on-device AI
  - mlkit
  - google mlkit
  - optical character recognition
  - ocr
  - google ai
  - google android
  - android
toc: true
---

![](/assets/img/mlkit1.jpg)

Google MLKit [1] is a software solution for Machine Learning problems in mobile devices (Android and iOS).
It supports computer visions and natural language applications.
The library is optimized for mobiles and is convenient.
In this example, we build a mobile OCR solution with Android CameraX API [2].
The demo code can be seen at [my Github](https://github.com/wanted2/mocr-mlkit-camerax-examples).
<!--more-->

## Introduction

<div>
<img style="float: left; margin-right: 40px;" src="https://github.com/wanted2/mocr-mlkit-camerax-examples/raw/main/screen.gif" />
</div>

We build a real-time demo shown in the left figure.

* When a user tap on the screen, a bounding box surrounding the location being tapped is the detection area from which text characters are recognized.

* The recognized text is detected in real-time and displayed at the bottom sheet.
* CameraX API supports invocations of image analysis whenever an image is captured.


## Setup
### Google MLKit setup

Since Text Recognition API does not support local models, we have to make the application downloading the model weights through Play services (i. e., Firebase).
This can be done by using the presets in `build.gradle`:

```gradle
    implementation 'com.google.android.gms:play-services-mlkit-text-recognition:16.2.0'
```

### CameraX setup
We also need to add presets for CameraX.
With this API, all events such as start capturing, handling when an image's available, stop capturing are bound automatically to the cameraX lifecycle.
The lifecycle is initialized with a camera selector, an image analyzer, and a `Preview`.
```gradle
    def camerax_version = "1.1.0-alpha04"
    implementation "androidx.camera:camera-core:${camerax_version}"
    implementation "androidx.camera:camera-camera2:${camerax_version}"
    implementation "androidx.camera:camera-lifecycle:${camerax_version}"
```

## Camera lifecycle

### Initializing the lifecycle
CameraX API binds all events in a camera into a lifecycle.
To preview captured image sequence, we need to add to the main layout a `PreviewView` component:

```xml
    <androidx.camera.view.PreviewView
        android:id="@+id/fs_cam_preview"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />
```
The captured images will be displayed here, and in the code of the main activity, we retrieve the view:

```java
mContentView = findViewById(R.id.fs_cam_preview);
```

For concurrency, there is a `com.google.common.util.concurrent.ListenableFuture` class to wrap up the `ProcessCameraProvider` to multi-processing:
```java
private ListenableFuture<ProcessCameraProvider> cameraProviderListenableFuture;
```
The process provider is initialized as follows (in `onCreate()`):
```java
        cameraProviderListenableFuture = ProcessCameraProvider.getInstance(this);
        cameraProviderListenableFuture.addListener(() -> {
            try {
                ProcessCameraProvider processCameraProvider = cameraProviderListenableFuture.get();
                bindPreview(processCameraProvider);
            } catch (ExecutionException | InterruptedException e) {
                Logger.e(e, "ERROR: ");
            }
        }, ContextCompat.getMainExecutor(this));
```
Heavyweight resources such as image analysis, previewing, and camera selection can be bind to the lifecycle owner in the `bindPreview` function:

```java
    private void bindPreview(ProcessCameraProvider processCameraProvider) {
        Preview preview = new Preview.Builder().build();
        CameraSelector cameraSelector = new CameraSelector.Builder()
                .requireLensFacing(CameraSelector.LENS_FACING_BACK)
                .build();
        preview.setSurfaceProvider(mContentView.getSurfaceProvider());
        Camera camera = processCameraProvider.bindToLifecycle(this, cameraSelector, imageAnalysis, preview);
    }
```
For ease of use, we initialized the back camera with `CameraSelector.LENS_FACING_BACK`.
And the preview is bound to a view `mContentView`.

With the `ProcessCameraProvider`, the heavyweight resources are managed efficiently by the lifecycle owner.
Using the CameraX API, we pay less for managing the lifecycles and with more reliable processing.

### Image Analyzer

A useful tool in CameraX API is the `ImageAnalyzer` interface, which is used to define custom Image Processing pipelines.
Here, whenever an image capture is returned in the form of `ImageProxy` instances, we need to get the image, crop the region of interest and do real-time text recognition.
Such a pipeline can be done in `ImageAnalysis.Analyzer.analyze`'s body.
To keep track of the location user touched in the screen, we have a `posisition`:
```java
private Point position;
```

And the custom image analysis pipeline:
```java
    private class MLKitAnalyzer implements ImageAnalysis.Analyzer {
        TextRecognizer textRecognizer;

        public MLKitAnalyzer() {
            textRecognizer = TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS);
            Logger.i("Loaded text recognition models!");
        }

        @Override
        public void analyze(@NonNull ImageProxy image) {
            @SuppressLint("UnsafeOptInUsageError") Image image1 = image.getImage();
            Logger.i(position.toString());
            Logger.i("Canvas size: " + overlayView.getWidth() + ", " + overlayView.getHeight());
            int width = overlayView.getWidth();
            int height = overlayView.getHeight();
            int mx = Math.min(width, height) / 4;
            int my = mx / 2;
            int left = position.x - mx;
            int top = position.y - my;
            int right = position.x + mx;
            int bottom = position.y + my;

            if (image1 != null) {
                ImageConvertUtils convertUtils = ImageConvertUtils.getInstance();
                InputImage inputImage = InputImage.fromMediaImage(image1, image.getImageInfo().getRotationDegrees());
                Bitmap bitmap;
                try {
                    bitmap = convertUtils.convertToUpRightBitmap(inputImage);
                } catch (MlKitException e) {
                    Logger.e(e, "ERROR");
                    return;
                }
                Rect rect = new Rect(Math.max(0, left * bitmap.getWidth() / width),
                        Math.max(0, top * bitmap.getHeight() / height),
                        right * bitmap.getWidth() / width,
                        bottom * bitmap.getHeight() / height);
                Bitmap crop = Bitmap.createBitmap(bitmap, rect.left, rect.top,
                        Math.min(bitmap.getWidth(), rect.right) - rect.left,
                        Math.min(bitmap.getHeight(), rect.bottom) - rect.top);
                inputImage = InputImage.fromBitmap(crop, 0);
                Logger.i("Image size: " + inputImage.getWidth() + ", " + inputImage.getHeight());
                Task<Text> results = textRecognizer.process(inputImage)
                        .addOnSuccessListener(text -> {
//                            overlayView.setLatestText(text);
                            overlayView.setPosistion(position);
                            Logger.i("Found text:" + text.getText());
                            overlayView.invalidate();
                            TextView txtDetected = sheetView.findViewById(R.id.txt_detected);
                            txtDetected.setText(text.getText());
                        })
                        .addOnFailureListener(e -> {
                            Logger.e(e, "ERROR");
                        })
                        .addOnCompleteListener(task -> image.close());
            }
        }
    }
```

The recognizer is initialized in the constructor, and it will take some seconds for the first time since the model needs to be downloaded from Firebase.

After the text blocks are detected, we will display the results in a bottom sheet.
A green rectangle with an aspect ratio of 2:1 is drawn around the touched location after passing the `position` to the `OverlayView` class.

## Google MLKit
<img style="float: right; margin-left: 40px;" width="50%" src="/assets/img/mlkit2.jpg" />
The Machine Learning pipeline running in the Image Analyzer is real-time, and the precision is quite good.
By limiting the search region to a `256 x 128` rectangle with the center is the touched location seems to be helpful to reduce the false alarms (noisy text).
It can be a good interaction since apps like searching for words in English often need to focus only on one compound word.
For example, foreign tourists (people who don't use English), when looking for unknown words, may only need to adjust the rectangle to the word they don't know.

## Conclusion

I used Google MLKit and Android CameraX API to build a lightweight mobile OCR application, the `mOCR`.
The result is a real-time recognition achieved by CameraX and MLKit.
The accuracy is good with a focused design in human user interaction.
A promising application should look into dictionaries for signs in metro stations or airports, and it is helpful in the Olympics.

The next step is to add the dictionary lookup to `mOCR`.



## References

{% bibliography --file mlkit %}