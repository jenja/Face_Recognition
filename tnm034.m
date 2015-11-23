function id = tnm034( im )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%Create training set


%White balance the image im
WB = GrayWorld(im);

% Checks which value whos lowest of the original image or the Gray World-image
imDiv = GrayWorldDiv(im);
wbDiv = GrayWorldDiv(WB);

whiteBalanced = BestIm(imDiv, wbDiv, im, WB);

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

%figure
%imshow(eyeMap)
%title('resulting eyeMap');

%Create mouthMap
mouthMap = createMouthMap(detectedFace);
%Use the maps to crop image im

transIm = transformImage( eyeMap, whiteBalanced );

% figure
% imshow(transIm)
% title('Transformed image');


%Use eigenfaces for recognition

%return the id of the image
%0 = no mathch
id = 0;

end

