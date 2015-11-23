%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WORKINGFILE
% Lock at transformImage for the commented and finished file
%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all

im = imread('DB1/db1_09.jpg');
%im = imread('DB0/db0_1.jpg');

WB = GrayWorld(im);

imDiv = GrayWorldDiv(im);
wbDiv = GrayWorldDiv(WB);

whiteBalanced = BestIm(imDiv, wbDiv, im, WB);

detectedFace = FaceDetection(whiteBalanced);

eyeMapC = createEyeMapC(detectedFace);
eyeMapL = createEyeMapL(detectedFace);


eyeMap = eyeMapC.*eyeMapL;

% figure
% imshow(eyeMap)
% title('EyeMap');

bweye = im2bw(eyeMap, 0.3);

[row, col] = size(eyeMap);

bweye(1:(floor(row/2 - 50)), :) = 0;
bweye(floor(row/2 + 50):row, :) = 0;

bweye(:, 1:(floor(col/2 - 100))) = 0;
bweye(:, floor(col/2 + 100):col) = 0;

se = strel('disk', 1);
se2 = strel('disk', 3);

% Expands cracks and removes noise
bweye = imerode(bweye, se);
bweye = imerode(bweye, se);
bweye = imerode(bweye, se);
bweye = imerode(bweye, se2);
bweye = imdilate(bweye, se);


% imshow(bweye)
% title('Image with Circles')

%cc = bwconncomp(bweye); 
stats = regionprops('table',bweye,'Centroid', 'MajorAxisLength','MinorAxisLength');

%idx = find([stats.MajorAxisLength] > 15 );
%BW2 = ismember(labelmatrix(cc), idx);

table = sortrows(stats, 3, 'descend');
table = table(1:2, :);

%imshow(BW2)
%title('Image with Circles')

centers = table.Centroid;
diameters = mean([table.MajorAxisLength table.MinorAxisLength],2);
radii = diameters/7;
% 
% hold on
% viscircles(centers,radii);
% figure
% hold off

A = round(table2array(table(1,1)));
B = round(table2array(table(2,1)));

eyeMid = round(A + (B - A)/2);

eyeMove(1,1) = round(col/2) - round(eyeMid(1,1)); 
eyeMove(1,2) = round(row/2) - round(eyeMid(1,2));

imTrans = imtranslate(WB,[round(eyeMove(1,1)), round(eyeMove(1,2))], 'FillValues', 1);


C = A;
C(1,2) = col;

a = B - A;
b = C - A;

costheta = dot(a,b)/(norm(a)*norm(b));
theta = acos(costheta);

rotim = imrotate(imTrans,-theta, 'bilinear', 'crop');


eyeScale = eyeMove(1,1)/50;

if eyeScale < 0.9
    eyeScale = 0.9;
elseif eyeScale > 1.1
    eyeScale = 1.1;
end

scalim = imresize(rotim, eyeScale, 'bicubic');


subplot(1,4,1);imshow(WB);
title('Orginal')
subplot(1,4,2);imshow(imTrans);
title('Trans')
subplot(1,4,3);imshow(rotim);
title('Rot')
subplot(1,4,4);imshow(scalim);
title('Scale')

