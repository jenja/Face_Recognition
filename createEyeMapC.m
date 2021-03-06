% TNM034 - ADVANCED IMAGE PROCESSING
% Isabell Jansson            isaja187
% Ronja Grosz                rongr946
% Christoffer Engelbrektsson chren574
% Jens Jakobsson             jenja698
% 2015-12-11
%------------------------------------

function eyeMapC = createEyeMapC( im )
%   This function should find the chromainance eye map from
%   an input image im, returns the found eye map
%   The input image should already have a face detected

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

% Histogram equalization
eyeMapC = histeq(eyeMapC); 


end