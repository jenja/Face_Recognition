% TNM034 - ADVANCED IMAGE PROCESSING
% Isabell Jansson            isaja187
% Ronja Grosz                rongr946
% Christoffer Engelbrektsson chren574
% Jens Jakobsson             jenja698
% 2015-12-11
%------------------------------------

function eyeMapL = createEyeMapL( im )
%The function should find the luma(?) eye map from
%an input image im, return the found eye map

% Change the colorspace to YCbCr
%This is probebly already done in the tnm034 function
%later on...but for now we do it here :)
YCbCr = rgb2ycbcr(im);

YCbCr = im2double(YCbCr);

Y = YCbCr(:,:,1);

%Defines the area where the dilation
%and erotion acts on
%Which size is best?
g = strel('disk',1, 8);

eyeMapL = (imdilate(Y,g))./(imerode(Y,g) + 1);


end
