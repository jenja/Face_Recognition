function out = YCbCr( im )
%UNTITLED3 Summary of this function goes here
% 

% Whitebalande the picture
im = whitebalance(im);

% Convert pixelvalues to doubles
im = im2double(im);

% Change the colorspace to YCbCr
YCbCr = rgb2ycbcr(im);
Y = YCbCr(:,:,1);
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

% Set irrelevent pixels to black
%YCbCr(  (Cr > (105/255)) & (Cr < (135/255))) = 0;
Cr(  (Cr > (105/255)) & (Cr < (135/255))) = 0;
%Cr(  (Cr > (140/255)) & (Cr < (165/255)) ) = 0;
%YCbCr(  (Cr > (140/255)) & (Cr < (165/255)) & (Cb > (105/255)) & (Cb < (135/255)) ) = 0;

%Otsu's method
level = graythresh(YCbCr)

Cri = im2bw(Cr , level);
%Cri = im2bw(YCbCr , 0.4);

figure
imshow(Cri)

% se = strel('disk', 3);
% se2 = strel('disk', 9);
% se3 = strel('disk', 6);

se = strel('disk', 3);
se2 = strel('disk', 20);
se3 = strel('disk', 12);

% erosion and dialation
MorphFace  = imerode(imdilate(imerode(Cri, se), se2), se3);

% Fill all leftover holes
MorphFace = imfill(MorphFace, 'holes');

figure, imshow(MorphFace)

% Convert to RGB and seperate the channels
RGB = ycbcr2rgb(YCbCr);
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

% Segmentation
R(MorphFace ~= 1) = 0;
G(MorphFace ~= 1) = 0;
B(MorphFace ~= 1) = 0;

% Return RGB-chanels to one picture
Result = cat(3, R, G, B);

figure
imshow(Result)

end

