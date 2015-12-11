% TNM034 - ADVANCED IMAGE PROCESSING
% Isabell Jansson            isaja187
% Ronja Grosz                rongr946
% Christoffer Engelbrektsson chren574
% Jens Jakobsson             jenja698
% 2015-12-11
%------------------------------------

function FilteredRegion = FilterEyeRegion( eyeMap )
%Filter the image from noice
%   Indata: Eyemap

% Threshold
TD = 0.75;

% Find the maximun intensity value
maxpixvalue = max(max(eyeMap));

% Set pixels with values below the threshold to black
eyeMap(eyeMap<TD*maxpixvalue) = 0;

% Convert to binary image
bweyeMap = im2bw(eyeMap);

% Dialate the image
se = strel('disk',4);
FilteredRegion = imdilate(bweyeMap, se);

end

