function EyeRegion = FindEyeRegion( FaceRegion )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[rNum, cNum, ~] = size(FaceRegion);

EyeDetect = vision.CascadeObjectDetector('EyePairBig');

% Find borders
BB = step(EyeDetect, FaceRegion);

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
EyeRegion(:,:,1) = EyeRegion(:,:,1).*mask;
EyeRegion(:,:,2) = EyeRegion(:,:,2).*mask;
EyeRegion(:,:,3) = EyeRegion(:,:,3).*mask;

end

