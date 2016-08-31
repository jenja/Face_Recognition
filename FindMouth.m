% TNM034 - ADVANCED IMAGE PROCESSING
% Isabell Jansson            isaja187
% Ronja Grosz                rongr946
% Christoffer Engelbrektsson chren574
% Jens Jakobsson             jenja698
% 2015-12-11
%------------------------------------

function Mouth = FindMouth( mouthMap )
% Find the coordinate of the mouth in the image 

% Create a black & white image with a treshold
bwmouth = im2bw(mouthMap, 0.3);

% How many rows the image have
[row, ~] = size(mouthMap);

% Remove noice and unnecessary data around the center where the mouth likly is.
bwmouth(1:(floor(2*row/3 - 50)), :) = 0;
bwmouth(floor(3*row/4 + 50):row, :) = 0;

% Morphological structuring element of two disks with different radii
se = strel('disk', 1);
se2 = strel('disk', 3);

% Expands cracks and removes noise
bwmouth = imerode(bwmouth, se);
bwmouth = imerode(bwmouth, se);
bwmouth = imerode(bwmouth, se2);
bwmouth = imdilate(bwmouth, se);
bwmouth = imdilate(bwmouth, se2);

title('Image with Circles')

% Sort the data in the image and create a table with it
stats = regionprops('table',bwmouth,'Centroid', 'MajorAxisLength','MinorAxisLength');
table = sortrows(stats, 3, 'descend');

% The data with the heighest value is most likly to be the mouth 
Mouth = round(table2array(table(1,1)))

end

