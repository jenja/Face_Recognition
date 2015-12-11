% TNM034 - ADVANCED IMAGE PROCESSING
% Isabell Jansson            isaja187
% Ronja Grosz                rongr946
% Christoffer Engelbrektsson chren574
% Jens Jakobsson             jenja698
% 2015-12-11
%------------------------------------

function EyeRegion = FindEyeRegion( FaceRegion, im )
%Detect the eyes in the image
%   Viola-Jones algorthm is used

[rNum, cNum, ~] = size(im);

EyeDetect = vision.CascadeObjectDetector('EyePairBig');

% Find borders
BB = step(EyeDetect, im);

centerX = BB(1,1)+BB(1,3)/2;
centerY = BB(1,2)+BB(1,4)/2;

% Define parameters of the rectangle
windowWidth = BB(1,3);
windowHeight = BB(1,4);

% Create logical mask
[yy, xx] = ndgrid((1:rNum)-centerY, (1:cNum)-centerX);
mask = xx < -windowWidth/2 | xx > windowWidth/2 | ...
    yy < -windowHeight/2 | yy > windowHeight/2;

% Mask image and show it
EyeRegion = im2double(FaceRegion);
mask = ~mask;

% Mask gray image
EyeRegion = EyeRegion.*mask;

end

