function Mouth = FindMouth( mouthMap )
% Find the coordinate of the mouth in the image 
%   Detailed explanation goes here

bwmouth = im2bw(mouthMap, 0.3);

[row, ~] = size(mouthMap);

bwmouth(1:(floor(2*row/3 - 50)), :) = 0;
bwmouth(floor(3*row/4 + 50):row, :) = 0;

% bwmouth(:, 1:(floor(2*col/3 - 100))) = 0;
% bwmouth(:, floor(2*col/3 + 100):col) = 0;

se = strel('disk', 1);
se2 = strel('disk', 3);

% Expands cracks and removes noise
bwmouth = imerode(bwmouth, se);
bwmouth = imerode(bwmouth, se);
bwmouth = imerode(bwmouth, se2);
bwmouth = imdilate(bwmouth, se);
bwmouth = imdilate(bwmouth, se2);


%imshow(bwmouth)
title('Image with Circles')

%cc = bwconncomp(bwmouth); 
stats = regionprops('table',bwmouth,'Centroid', 'MajorAxisLength','MinorAxisLength');

%idx = find([stats.MajorAxisLength] > 15 );
%BW2 = ismember(labelmatrix(cc), idx);

table = sortrows(stats, 3, 'descend');
%table = table(1:2, :);

% figure
% imshow(BW2)
% title('Image with Circles')
% 
% centers = table.Centroid;
% diameters = mean([table.MajorAxisLength table.MinorAxisLength],2);
% radii = diameters/2;


Mouth = round(table2array(table(1,1)))


end

