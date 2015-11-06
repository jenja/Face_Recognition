function is = ModYCbCr( im )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


[X, Y2, Z] = size(im);

Y = zeros(X, Y2);
Cb = zeros(X, Y2);
Cr = zeros(X, Y2);
% 
% R = im(:,:,1)
% G = im(:,:,2)
% B = im(:,:,3)

R = im2double(im(:,:,1))*255;
G = im2double(im(:,:,2))*255;
B = im2double(im(:,:,3))*255;

Y = 16 + 1/256 .* (65.738.*R + 129.057.*G + 25.064.*B);
Cb = 128 + 1/256 .* (-37.945.*R - 74.494.*G + 112.439.*B);
Cr = 128 + 1/256 .* (112.439.*R - 94.154.*G - 18.285.*B);

Y = Y(:);
Cb = Cb(:);
Cr = Cr(:);

%idx = kmeans([Y Cb Cr], 2);
idx = kmeans([Y Cb Cr], 3);
%idx = kmeans([Y Cb Cr], 4);

figure;
imshow(ind2rgb(reshape(idx, size(im,1), size(im, 2)), [0 0 1; 0 0.8 0]))


end

