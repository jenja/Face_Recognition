function eyeMapC = createEyeMapC( im )
%The function should find the chromatic(?) eye map from
%an input image im, return the found eye map
%The input image should already has a face detected

close all

%im = whitebalance(im);

% Change the colorspace to YCbCr
%This is probebly already done in the tnm034 function
%later on...but for now we do it here :)
YCbCr = rgb2ycbcr(im);

YCbCr = im2double(YCbCr);

Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

%Since we're working with doubles, we're using 1 - Cr
%instead of 255 - Cr as the article says
Cr2 = 1 - Cr;

eyeMapC = (1/3)*(Cb.*Cb +  Cr2.*Cr2 + Cb./Cr );

figure
imshow(eyeMapC)
title('EyeMapC');


% figure
% eyeMapC=histeq(eyeMapC);
% imshow(eyeMapC)
% title('Equalized EyeMapC');

end