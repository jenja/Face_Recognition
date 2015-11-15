function out = YCbCr_vs2( im )
%YCBCR_VS2 Summary of this function goes here
% A combination of the method used in the first version
% and a method used in the lecture 

% Whitebalande the picture
im = whitebalance(im);

% Convert pixelvalues to doubles
im = im2double(im);

% Change the colorspace to YCbCr
YCbCr = rgb2ycbcr(im);
Y = YCbCr(:,:,1);
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

% Threshold to set irrelevent pixels to black
Cr(  (Cr > (105/255)) & (Cr < (135/255))) = 0;
%Cb( (Cb > (105/255)) & (Cb < (135/255))) = 0;

% Skin color samples in (Cb/Y) - (Cr/Y) subspace
mask = (Cr./Y - Cb./Y) > 0.10;

% Fill in holes in the binary image mask
mask = imfill(mask, 'holes');

% Matlab magic
% creates a flat, disk-shaped structuring element, 
% the constant specifies the radius
% used for the erosion and dilation
% Can also try the values 3, 20 , 12
se = strel('disk', 3);
se2 = strel('disk', 9);
se3 = strel('disk', 6);

% erosion and dialation
MorphFace = imerode(imdilate(imerode(mask, se), se2), se3);

% Fill all leftover holes
MorphFace = imfill(MorphFace, 'holes');

% Convert to RGB and seperate the channels
im = im2double(im);
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

% Segmentation
R(R > MorphFace) = 0;
G(G > MorphFace) = 0;
B(B > MorphFace) = 0;
result = cat(3, R, G, B);

imshow(result);

end