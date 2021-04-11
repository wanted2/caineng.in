---
layout: post
title: "Animal Vision Part 2: Image Processing for Noise Analytics"
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
  - noise reduction
  - noise analysis
  - image restoration
  - spatial filters
  - image filters
  - frequency filters
  - fourier transform
toc: true
---
![](/assets/img/boss-dog-2.jpg)
_Source: [Burst Free Photo Stock](https://burst.shopify.com/photos/dog-running-in-fall-leaves?c=dog)_
<!--more-->
## Image Filtering and Frequency Filters

### 2-D Fourier Transforms

The analogue Fourier Transform (FT) converts a spatial function $f(x,y)$ to frequency function $F(u,v)$ as follows:

$$F(u,v)=\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}f(x,y)e^{-2\omega\pi (ux+vy)}dxdy$$

It is known that there are some conveniences for performing filter operations in frequency space $(u,v)$ rather than in input space $(x,y)$.
For example, when we want to cut off low-frequency components in image $f(x,y)$, it will be easier to do it in $F(u,v)$.

Since images are digital signals, we should focus on the discrete version, Discrete Fourier Transform (DFT), which is defined on the input image $I$ as follows.

$$X_{k,l}=\sum_{i=0}^{W-1}\sum_{j=0}^{H-1}I_{i,j}e^{-2\omega\pi (\frac{ki}{W}+\frac{lj}{H})}, 0\leq k < W, 0\leq l < H$$

where, we substituted $di=\frac{1}{W}, dj=\frac{1}{H}$, $I_{i,j}$ be the pixel value at row $i$ and column $j$.
We can see that a Fourier function $X_{k,l}$ is a periodic function in both horizontal and vertical dimensions.
In other words,

$$X_{k+W,l}=X_{k,l+H}=X_{k,l}$$

The complexity of DFT is an order of squares, i. e., $O(W\times H)$.
To accelerate the computation, Fast Fourier Transform (FFT) has been proposed.

### Low-pass filter, high-pass filter, and band-pass filter

```python
def low_pass_filter(img, alpha=0.5):
    # Fast Fourier Transform
    Xsrc = np.fft.fft2(img)
    # exchange 1st<->3rd quarter and 2nd<->4th quarter
    Xsrc = np.fft.fftshift(Xsrc)
    h, w = img.shape
    cy, cx= int(h/2), int(w/2)
    ax, ay = int(alpha*cx), int(alpha*cy)
    Xdest = np.zeros(img.shape, dtype=np.complex)
    # cut off low frequencies
    Xdest[cy-ay:cy+ay, cx-ax:cx+ax] = Xsrc[cy-ay:cy+ay, cx-ax:cx+ax]
    # Inverse Fast Fourier Transform
    out = np.fft.fftshift(Xdest)
    # exchange 1st<->3rd quarter and 2nd<->4th quarter
    out = np.fft.ifft2(out)
    spectrum = 20*np.log(np.abs(Xdest))
    return np.real(out).astype(np.uint8), np.imag(out).astype(np.uint8), spectrum

def high_pass_filter(img, alpha=0.5):
    # Fast Fourier Transform
    Xsrc = np.fft.fft2(img)
    # exchange 1st<->3rd quarter and 2nd<->4th quarter
    Xsrc = np.fft.fftshift(Xsrc)
    h, w = img.shape
    cy, cx= int(h/2), int(w/2)
    ax, ay = int(alpha*cx), int(alpha*cy)
    Xdest = Xsrc.copy()
    Xdest[cy-ay:cy+ay, cx-ax:cx+ax] = np.zeros(Xsrc[cy-ay:cy+ay, cx-ax:cx+ax].shape, dtype=np.complex)
    out = np.fft.fftshift(Xdest)
    out = np.fft.ifft2(out)
    spectrum = 20*np.log(np.abs(Xdest))
    return np.real(out).astype(np.uint8), np.imag(out).astype(np.uint8), spectrum

def band_pass_filter(img, alpha=0.5, beta=0.25):
    # Fast Fourier Transform
    Xsrc = np.fft.fft2(img)
    # exchange 1st<->3rd quarter and 2nd<->4th quarter
    Xsrc = np.fft.fftshift(Xsrc)
    h, w = img.shape
    cy, cx= int(h/2), int(w/2)
    ax, ay = int(alpha*cx), int(alpha*cy)
    ax2, ay2 = int(beta*cx), int(beta*cy)
    Xdest = Xsrc.copy()
    Xdest[cy-ay:cy+ay, cx-ax:cx+ax] = np.zeros((2*ay, 2*ax), dtype=np.complex)
    Xdest[cy-ay2:cy+ay2, cx-ax2:cx+ax2] = Xsrc[cy-ay2:cy+ay2, cx-ax2:cx+ax2]
    out = np.fft.fftshift(Xdest)
    out = np.fft.ifft2(out)
    spectrum = 20*np.log(np.abs(Xdest))
    return np.real(out).astype(np.uint8), np.imag(out).astype(np.uint8), spectrum
```
## Image Restoration

## Reference

{% bibliography --file aniv2 %}

## Posts

1. [x] [__Introduction__](/cv/ai/2021/03/06/animal-vision-series-part-1.html)
2. [x] __Introduction about Computer Vision (using `scikit-image` and `opencv`) (this post)__
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