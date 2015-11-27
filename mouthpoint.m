%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WORKINGFILE
% Lock at transformImage for the commented and finished file
%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all

im = imread('DB1/db1_16.jpg');
%im = imread('DB0/db0_3.jpg');

WB = GrayWorld(im);

imDiv = GrayWorldDiv(im);
wbDiv = GrayWorldDiv(WB);

whiteBalanced = BestIm(imDiv, wbDiv, im, WB);

detectedFace = FaceDetection(whiteBalanced);

mouthMap = createMouthMap(detectedFace);

% figure
% imshow(eyeMap)
% title('EyeMap');

bwmouth = im2bw(mouthMap, 0.3);

[row, ~] = size(mouthMap);

bwmouth(1:(floor(2*row/3 - 50)), :) = 0;
bwmouth(floor(3*row/4 + 50):row, :) = 0;

se = strel('disk', 1);
se2 = strel('disk', 3);

% Expands cracks and removes noise
bwmouth = imerode(bwmouth, se);
bwmouth = imerode(bwmouth, se);
bwmouth = imdilate(bwmouth, se);
bwmouth = imdilate(bwmouth, se2);
bwmouth = imerode(bwmouth, se2);

% imshow(bwmouth)
% title('Image with Circles')

cc = bwconncomp(bwmouth); 
stats = regionprops('table',bwmouth,'Centroid', 'MajorAxisLength','MinorAxisLength');

idx = find([stats.MajorAxisLength] > 15 );
BW2 = ismember(labelmatrix(cc), idx);

table = sortrows(stats, 3, 'descend');

figure
imshow(BW2)
title('Image with Circles')

centers = table.Centroid;
diameters = mean([table.MajorAxisLength table.MinorAxisLength],2);
radii = diameters/2;

hold on
viscircles(centers,radii);
hold off

Mouth = round(table2array(table(1,1)));



