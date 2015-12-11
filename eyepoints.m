
close all

%im = imread('DB1/db1_16.jpg');
%im = imread('DB0/db0_3.jpg');
im = imread('DB2/bl_06.jpg');

%White balance the image im
WB = GrayWorld(im);

% Checks which value whos lowest of the original image or the Gray World-image
imDiv = GrayWorldDiv(im);
wbDiv = GrayWorldDiv(WB);

whiteBalanced = BestIm(imDiv, wbDiv, im, WB);

% figure
% imshow(whiteBalanced)
% title('resulting gray world');

%Detect face in image im
detectedFace = FaceDetection(whiteBalanced);

mouthMap = createMouthMap(detectedFace);

Mouth = FindMouth( mouthMap )

% figure
% imshow(detectedFace)
% title('resulting detection');

%Use only the detected face when creating the eyeMaps
%Create eye maps
eyeMapC = createEyeMapC(detectedFace);
eyeMapL = createEyeMapL(detectedFace);

%Combine the eye maps
%This could maybe be improved
eyeMap = eyeMapC.*eyeMapL;

% Cinvert to binary image
bweyeMap = im2bw(eyeMap, 0.3);

% Get size of row and column
[row, col] = size(bweyeMap);

% Remove everyting over the eyes
bweyeMap(1:(floor(row/4)), :) = 0;
bweyeMap(floor(2*row/4):row, :) = 0;

figure
imshow(bweyeMap)

se = strel('disk', 1);
se2 = strel('disk', 3);

% removes noise and expand
bweyeMap = imerode(imerode(imerode(imerode(bweyeMap, se), se), se), se2);
%bweyeMap = imerode(imerode(bweyeMap, se), se2);
bweyeMap = imdilate(bweyeMap, se);

% Find circles
stats = regionprops('table',bweyeMap,'Centroid', 'MajorAxisLength','MinorAxisLength');

% Sort table by eyesize
table = sortrows(stats, 3, 'descend');
%table = table(1:2, :);

centers = table.Centroid;
diameters = mean([table.MajorAxisLength table.MinorAxisLength],2);
radii = diameters/2;

hold on
viscircles(centers,radii);
hold off

eyeArray = round(table2array(table(:, 1)));


for i = 1:height(table)
    if eyeArray(i,2) > Mouth(1,2)
        eyeArray(i, :) = [];
    end
end


[xm, ym] = size(eyeArray);

eyeArrayC = zeros(2,2);

% for i = 1:xm
%     if (eyeArray(i, 1) < (Mouth(1,2)+col/10)) && (eyeArray(i, 1) < (Mouth(1,2)-col/10))
%         eyeArrayC(i, :) = eyeArray(i, :);
%     end
% end


for i = 1:ym
    if (eyeArray(i, 1) < (Mouth(1,1)+col/8)) && (eyeArray(i, 1) > (Mouth(1,1)-col/8))
        eyeArrayC(1, i) = eyeArray(1, i);
    end
end
% Array of the eyes

eyeArrayS = sortrows(eyeArrayC)

leftEye = eyeArrayS(1, :);
rightEye = eyeArrayS(2, :);

% Find the koordinate of the midpoint between the eyes
eyeMid = round(leftEye + (rightEye - leftEye)/2);

eyeCoord = [leftEye; rightEye; eyeMid]