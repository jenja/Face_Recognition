function FilteredRegion = FilterEyeRegion( eyeMap )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

TD = 0.75;

maxpixvalue = max(max(eyeMap));
eyeMap(eyeMap<TD*maxpixvalue) = 0;
bweyeMap = im2bw(eyeMap);
%FilteredRegion = bweyeMap;

se = strel('disk',4);
FilteredRegion = imdilate(bweyeMap, se);



end

