function FilteredRegion = FilterEyeRegion( eyeMap )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% Convert to binary image
bweyeMap = im2bw(eyeMap, 0.3);

% Attempt to get a dynamic threshold 
% for Level = 1:-0.1:0
%    bweyeMap = im2bw(eyeMap, Level);
%    stats = regionprops('table',bweyeMap,'Centroid', 'MajorAxisLength','MinorAxisLength')
%    hei = height(stats)
%    Level
%     if hei > 2
%        break;
%     end
% end

se1 = strel('disk',2);
se2 = strel('disk',4);

se3 = strel('disk',3);
se4 = strel('disk',1);

re = strel('rectangle',[7 7]);


FilteredRegion = imclose(bweyeMap, se1);

%FilteredRegion = imclose(FilteredRegion, se2);
%FilteredRegion = imclose(FilteredRegion, se3);
%FilteredRegion = imclose(FilteredRegion, se4);


FilteredRegion = imfill(FilteredRegion,'holes');
FilteredRegion = imerode(FilteredRegion,re);

%FilteredRegion = imerode(FilteredRegion,se1);

%FilteredRegion = imdilate(FilteredRegion,se1);
%FilteredRegion = imdilate(FilteredRegion,se1);

end

