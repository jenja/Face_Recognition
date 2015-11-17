function id = tnm034( im )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%Create training set

%White balance the image im
whiteBalanced = GrayWorld(im);

% figure
% imshow(whiteBalanced)
% title('resulting gray world');

%Detect face in image im
detectedFace = FaceDetection(whiteBalanced);

% figure
% imshow(detectedFace)
% title('resulting detection');

%Use only the detected face when creating the eyeMaps
%Create eye maps
eyeMapC = createEyeMapC(detectedFace);
eyeMapL = createEyeMapL(detectedFace);

%Combine the eye maps
%This could maybe be improved
eyeMap = eyeMapC.*eyeMapL;

figure
imshow(eyeMap)
title('resulting eyeMap');


%Create mouthMap
mouth = createMouthMap(detectedFace);
%Use the maps to crop image im

%Use eigenfaces for recognition

%return the id of the image
%0 = no mathch
id = 0;

end

