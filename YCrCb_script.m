image = imread('DB0/db0_3.jpg');

im = whitebalance(image);

im = im2double(im);
YCbCr = rgb2ycbcr(im);

Y = YCbCr(:,:,1);
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

Cr(  (Cr > (105/255)) & (Cr < (135/255)) ) = 0;

%Cb(Cb < (105/255) ) = 0;
%Cb(Cb > (135/255) ) = 0;

%Otsu's method
level = graythresh(Cr)

Cr = im2bw(Cr, level);
%imshow(Cr)
% figure
% imshow(Cb)


se = strel('disk', 3);
se2 = strel('disk', 9);
se3 = strel('disk', 6);

MorphFace  = imerode(imdilate(imerode(Cr, se), se2), se3);
%figure, imshow(MorphFace)

RGB = ycbcr2rgb(YCbCr);
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

R(MorphFace ~= 1) = 0;
G(MorphFace ~= 1) = 0;
B(MorphFace ~= 1) = 0;

Result = cat(3, R, G, B);

figure
imshow(Result)
