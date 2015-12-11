function eyeCoord = FindEyes( eyeMap )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


% Cinvert to binary image
bweyeMap = im2bw(map, 0.3);

% Get size of row and column
[row, col] = size(bweyeMap);

% Remove everyting over the eyes
bweyeMap(1:(floor(row/4)), :) = 0;
bweyeMap(floor(2*row/4):row, :) = 0;

%figure
%imshow(bweyeMap)

se = strel('disk', 1);
se2 = strel('disk', 3);

% removes noise and expand
bweyeMap = imerode(imerode(imerode(imerode(bweyeMap, se), se), se), se2);
bweyeMap = imdilate(bweyeMap, se);

% Find circles
stats = regionprops('table',bweyeMap,'Centroid', 'MajorAxisLength','MinorAxisLength');

% Sort table by eyesize
table = sortrows(stats, 3, 'descend');
table = table(1:2, :)

centers = table.Centroid;
diameters = mean([table.MajorAxisLength table.MinorAxisLength],2);
radii = diameters/2;

% Array of the eyes
eyeArray = sort(round(table2array(table(1:2, 1))));

leftEye = eyeArray(1, :);
rightEye = eyeArray(2, :);

% Find the koordinate of the midpoint between the eyes
eyeMid = round(leftEye + (rightEye - leftEye)/2);

eyeCoord = [leftEye rightEye eyeMid]


end

