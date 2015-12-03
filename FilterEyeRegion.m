function FilteredRegion = FilterEyeRegion( eyeMap )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%Deafult
Level = 0.3;

%Level = 0.25;

bweyeMap = im2bw(eyeMap, Level);

se1 = strel('disk',2);
se2 = strel('rectangle',[7 7]);

FilteredRegion = imclose(bweyeMap, se1);
FilteredRegion = imfill(FilteredRegion,'holes');
FilteredRegion = imerode(FilteredRegion,se2);
%FilteredRegion = imerode(FilteredRegion,se1);
FilteredRegion = imdilate(FilteredRegion,se1);
FilteredRegion = imdilate(FilteredRegion,se1);

end

