# Face Recognition

Gray world is used for white balancing the images. The face is detected by using the Viola-Jones algorithm. The eyes are extracted by eye maps which are used to align the faces. The aligned faces are matched by comparing important features in the faces.
The relevant features that have been studied are intensity and phase from the Fourier transform. The
intensity based method is called Eigenfaces, and the phase based method is called Local Phase Quantization.
For dimension reduction, Principal Component Analysis and Singular Value Decomposition
have been compared.

The Eigenface algorithm generally gives the highest matching rate, except from when considering
blurred images.

Note: this project was created with MATLAB and is required to run it.

For more details about this project, please see the [report](https://cdn.rawgit.com/jenja/Face_Recognition/master/Report/Face_Detection.pdf).

## How to run:

1. First you need to create a database by either using Eigenfaces or Local Phase Quantization. Run the file EFcreateDB.m or LPQcreateDB.m in matlab. (Note that if you want to use you own pictures you need to change the load function in the create database files, for now we are loading the pictures from DB1).

2. You need to change what database your are using in tnm034.m, either line 26 or 29.

3. Load the picture you want to compare with the database. Run the function tnm034(image) with your image as the argument. If the result is between 1-16, this meants it was successful to recognize the person (and hoppfully got it right). If the result is 0 (zero), then it failed to recognize the person.

This project was made by Isabell Jansson, Christoffer Engelbrektsson, Jens Jakobsson and Ronja Grosz in the course TNM034, Advanced Image Processing at Linköpings University.
