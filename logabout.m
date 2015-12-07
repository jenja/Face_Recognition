function outIm = logabout(im)
% LOGABOUT
%   LogAbout is a method to compensate variety of illumination
%   in Face Detection. It uses a Log transformation followed by
%   a high-pass filter.

im = rgb2gray(im);

%im = double(im);
im = im2double(im);

%High-pass filter
hpFilter = [-1 -1 -1; -1 9 -1; -1 -1 -1];

%Filter the image
im = imfilter(im, hpFilter);

imshow(im)
% Log transformation
% The parameters a,b and c controls the location and
% shape of the logarithmic curve
a = 0.2;
b = 0.6;
c = 0.9;
im = a + (log(im + 1)./(b * log(c)));

outIm = im;

figure
imshow(im)
 
end