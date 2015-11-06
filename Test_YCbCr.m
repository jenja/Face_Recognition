
I2 = imread('DB0/db0_1.jpg');
I2 = im2double(I2);
YCbCr = rgb2ycbcr(I2);
Y = YCbCr(:,:,1); Y = Y(:);
Cb = YCbCr(:,:,2); Cb = Cb(:);
Cr = YCbCr(:,:,3); Cr = Cr(:);

idx = kmeans([Y Cb Cr], 3);

figure;
imshow(ind2rgb(reshape(idx, size(I2,1), size(I2, 2)), [0 0 1; 0 0.8 0]))

clear