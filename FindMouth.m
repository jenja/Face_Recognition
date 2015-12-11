function Mouth = FindMouth( mouthMap )
% Find the coordinate of the mouth in the image 

bwmouth = im2bw(mouthMap, 0.3);

[row, ~] = size(mouthMap);

bwmouth(1:(floor(2*row/3 - 50)), :) = 0;
bwmouth(floor(3*row/4 + 50):row, :) = 0;

se = strel('disk', 1);
se2 = strel('disk', 3);

% Expands cracks and removes noise
bwmouth = imerode(bwmouth, se);
bwmouth = imerode(bwmouth, se);
bwmouth = imerode(bwmouth, se2);
bwmouth = imdilate(bwmouth, se);
bwmouth = imdilate(bwmouth, se2);

title('Image with Circles')

stats = regionprops('table',bwmouth,'Centroid', 'MajorAxisLength','MinorAxisLength');

table = sortrows(stats, 3, 'descend');


Mouth = round(table2array(table(1,1)))

end

