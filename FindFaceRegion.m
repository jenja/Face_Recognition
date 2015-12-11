function FaceRegion = FindFaceRegion( im )
%Detect the face in the image
%   Viola-Jones algorthm is used

FDetect = vision.CascadeObjectDetector;

%Returns Bounding Box values based on number of objects
BB = step(FDetect,im);
BB = sortrows(BB, -3);
BB = BB(1,:);

% Determine image properties
[rNum, cNum, ~] = size(im);

RecEdgeX = BB(1,1)+BB(1,3)/2;
RecEdgeY = BB(1,2)+BB(1,4)/2;

% Define parameters of the rectangle
windowWidth = 0.75*BB(1,3);
windowHeight = 0.9*BB(1,4);

% Create logical mask
[yy, xx] = ndgrid((1:rNum)-RecEdgeY, (1:cNum)-RecEdgeX);
mask = xx < -windowWidth/2 | xx > windowWidth/2 | ...
    yy < -windowHeight/2 | yy > windowHeight/2;

% Conevert to doubles
FaceRegion = im2double(im);

% Invert matrix
mask = ~mask;

% Return to RGB image
FaceRegion(:,:,1) = FaceRegion(:,:,1).*mask;
FaceRegion(:,:,2) = FaceRegion(:,:,2).*mask;
FaceRegion(:,:,3) = FaceRegion(:,:,3).*mask;

end

