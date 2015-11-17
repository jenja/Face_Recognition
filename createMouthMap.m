function MouthMap = createMouthMap( im )
% Returns a map for the mouth in the picture
% An input image im, return the found eye map

% Change the colorspace to YCbCr
YCbCr = rgb2ycbcr(im);
YCbCr = im2double(YCbCr);

Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

Cr2 = Cr.^2;
CrCb = Cr./Cb;

% Number of pixels in x-led, y-led and total.
[Xled, Yled] = size(Cb);
Number_of_pixels = Xled*Yled;

% Numerator and Denominator to calculate eta 
Num = sum(sum(Cr2))./Number_of_pixels;
Denom = sum(sum(CrCb))./Number_of_pixels;

% Ratio of the ave Cr2 to the avg CrCb
eta = 0.95 * Num/Denom ;

x = Cr2 - eta * CrCb;
MouthMap = Cr2.*x.*x;

% Normalize the map
MouthMap = MouthMap./ max(max(MouthMap));

% Defines the area where the dilation
g = strel('disk',4);
% Dilalate, need a better size 
MouthMap = (imdilate(MouthMap,g));
figure
imshow(MouthMap)
title('Mouth');

end

