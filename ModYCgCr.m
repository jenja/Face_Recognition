function id = ModYCgCr( im )
%UNTITLED4 Summary of this function goes here
% Transforming images to YCgCr and detects faces.
% NOT DONE and unsure of we will use it


[X, Y2, Z] = size(im);

Y = zeros(X, Y2);
Cb = zeros(X, Y2);
Cr = zeros(X, Y2);

% R = im(:,:,1)
% G = im(:,:,2)
% B = im(:,:,3)

R = im2double(im(:,:,1))*255;
G = im2double(im(:,:,2))*255;
B = im2double(im(:,:,3))*255;

% Convert to YCbCr
Y = 16 + 65.481.*R + 128.553.*G + 24.966*B;
Cb = 128 + 81.085.*R + 112.*G + 30.915*B;
Cr = 128 + 112.*R + 93.768.*G + 18.214*B;

% From 2D to 1D
Y = Y(:);
Cb = Cb(:);
Cr = Cr(:);

% Segmenting
idx = kmeans([Y Cb Cr], 4);

figure;
imshow(ind2rgb(reshape(idx, size(im,1), size(im, 2)), [0 0 1; 0 0.8 0]))

end

