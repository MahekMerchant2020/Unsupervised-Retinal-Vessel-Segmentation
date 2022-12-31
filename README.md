# Unsupervised Retinal Vessel Segmentation  

This project aims to employ image processing techniques for automatically segmenting retinal vessels from a picture.

## RetinalVesselSegmentation.m  

This MATLAB program automatically segments retinal vessels from an input image in the following steps:  

**Step 1:** Converting the image from RGB to the CIE Lab Colour Space  

**Step 2:** Performing Principal Component Analysis (PCA) to convert the CIE image into a grayscale image, followed by contrast-limited adaptive histogram equalisation (CLAHE)  

**Step 3:** Applying a 9 x 9 average filter to the contrast-enhanced grayscale image  

**Step 4:** Subtracting the filtered image from the original contrast-enhanced grayscale image  

**Step 5:** Implementing a heuristic approach to compute the global threshold  

**Step 6:** Binarising the image obtained after Step 4 using the global threshold calculated in Step 5  

**Step 7:** Removing noise by morphological area opening  

**Step 8:** Generating the segmented image  

## SegmentationAccuracy.m  

This MATLAB program reads an automatically segmented image and a manually segmented image and computes the difference between the two.  

A new matrix with the same dimensions as the automatically segmented image is initialised with zeroes.  

If a pixel at a particular position in the matrices of the automatically segmented image and the manually segmented image has the same intensity value, then the pixel intensity value in the new matrix at the same position is set to 1 (white). Otherwise, it is set to 0 (black).  

Thus, the accuracy is computed by dividing the sum of all pixel intensity values in the new matrix by the product of its dimensions.

**Segmentation Accuracy = 90.4898%**  

## References

__[Tyler Coye (2022), Novel Retinal Vessel Segmentation Algorithm: Fundus Images, MATLAB Central File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/50839-novel-retinal-vessel-segmentation-algorithm-fundus-images)__  

__[Bruce, Q. (2021, September 24), How to obtain blood vessels segmentation in retinal images using MATLAB, Section](https://www.section.io/engineering-education/how-to-obtain-blood-vessels-segmentation-in-retinal-images-using-matlab/)__
