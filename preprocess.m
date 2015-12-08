function outIm = preprocess( im )
% PREPOCESS
%   This function preprocess the image for recognition. This includes face
%   detection, features detection, face alignment and cropping.
%close all
%Dimension variables for the desired cropped image
minRows = 450;
minCols = 350;

% FACE DETECTION
%--------------------------------------------------------------------------
%White balance the image
WB = GrayWorld(im);

%Checks which value that's lowest, either the original 
%image or the Gray World-image

%Checks whatever the origignal or the Gray World-image has the lowest value
%This value should be as close to one as possible
imDiv = GrayWorldDiv(im);
wbDiv = GrayWorldDiv(WB);

whiteBalanced = BestIm(imDiv, wbDiv, im, WB);

%whiteBalanced = hist( whiteBalanced );

%Find face region
Face = FindFaceRegion( whiteBalanced );
%figure; imshow(Face)

%Detect face in image im
detectedSkin = SkinDetection(Face);
%figure; imshow(FilteredEyeRegion)

% FEATURES DETECTION: Eye map and Mouth map
%--------------------------------------------------------------------------
%Use only the detected face when creating the eyeMaps
%Create eye maps
eyeMapC = createEyeMapC(Face); %Chrominance
eyeMapL = createEyeMapL(Face); %Luminance
%figure; imshow(eyeMapC); figure; imshow(eyeMapL)

%Combine the eye maps
eyeMap = eyeMapC.*eyeMapL;
%figure; imshow(eyeMap)

%Filter eyemap
FilteredEyeRegion = FilterEyeRegion( eyeMap );
%figure; imshow(FilteredEyeRegion)

EyeRegion = FindEyeRegion( FilteredEyeRegion, Face );
%figure; imshow(EyeRegion)

%Create mouthMap, not yet used
%mouthMap = createMouthMap(detectedFace);

% FACE ALIGNMENT
%--------------------------------------------------------------------------
%Use the maps to scale the image so all eyes are placed 
%in at the same place. The output image has the same size
%as the input image
transIm = transformImage( EyeRegion, whiteBalanced );
%transIm = transformImage( FilteredEyeRegion, Face );
%figure; imshow(transIm)
% CROP
%--------------------------------------------------------------------------
 %Crop all images to equal size
[row,col,~] = size(transIm);

transIm = double(rgb2gray(transIm));
outIm = imcrop(transIm, [ ceil(col/2 - minCols/2) ceil(row/2 - minRows/3) (minCols-1) (minRows-1)] );
figure; imshow(outIm)

end

