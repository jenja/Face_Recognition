I2 = imread('DB0/db0_1.jpg');
%2 = im2double(I2);
HSV = rgb2hsv(I2);

% Separating the color channels
H = HSV(:,:,1); H = H(:);
S = HSV(:,:,2); S = S(:);
V = HSV(:,:,3); V = V(:);
X = [H S V];

%The best single channel from HSV varies depending on the image
%Hue (H) is the best channel for image one while Saturation (S)
% is the best channel for image 2.
% Using K-menas to segment the picture. We will probably not use this
% because unreliably results
idx = kmeans(H, 2);
figure;
imshow(ind2rgb(reshape(idx, size(I2,1), size(I2, 2)), [0 0 1; 0 1 0]))

clear