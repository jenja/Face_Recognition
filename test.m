im = imread('DB0/db0_1.jpg');
tnm034(im)

I2 = imread('DB0/db0_1.jpg');
I2 = im2double(I2);
HSV = rgb2hsv(I2);
H = HSV(:,:,1); H = H(:);
S = HSV(:,:,2); S = S(:);
V = HSV(:,:,3); V = V(:);
idx = kmeans([H S V], 2);
figure;
imshow(ind2rgb(reshape(idx, size(I2,1), size(I2, 2)), [0 0 1; 0 0.8 0]))
