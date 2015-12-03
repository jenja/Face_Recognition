close all
%im = imread('DB2/il_09.jpg');
%im = imread('DB2/ex_12.jpg');
im = imread('DB1/db1_13.jpg');


%im = imrotate(im,5);

%To detect Face
FDetect = vision.CascadeObjectDetector;
%Returns Bounding Box values based on number of objects
BB = step(FDetect,im);
BB = sortrows(BB, -3);
BB = BB(1,:);


% Determine image properties
[rNum, cNum, ~] = size(im);

B1 = BB(1,1);
B2 = BB(1,2);
B3 = BB(1,3);
B4 = BB(1,4);

centerX = BB(1,1)+BB(1,3)/2;
centerY = BB(1,2)+BB(1,4)/2;
% Define parameters of the rectangle
windowWidth = 0.75*BB(1,3);
windowHeight = 0.9*BB(1,4);


% Create logical mask
[yy, xx] = ndgrid((1:rNum)-centerY, (1:cNum)-centerX);
mask = xx < -windowWidth/2 | xx > windowWidth/2 | ...
    yy < -windowHeight/2 | yy > windowHeight/2;
% Mask image and show it
maskedImage = im2double(im);
mask = ~mask;
maskedImage(:,:,1) = maskedImage(:,:,1).*mask;
maskedImage(:,:,2) = maskedImage(:,:,2).*mask;
maskedImage(:,:,3) = maskedImage(:,:,3).*mask;

%imshow(maskedImage)

EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB2=step(EyeDetect,maskedImage);

centerX = BB2(1,1)+BB2(1,3)/2;
centerY = BB2(1,2)+BB2(1,4)/2;
% Define parameters of the rectangle
windowWidth = BB2(1,3);
windowHeight = BB2(1,4);


% Create logical mask
[yy, xx] = ndgrid((1:rNum)-centerY, (1:cNum)-centerX);
mask = xx < -windowWidth/2 | xx > windowWidth/2 | ...
    yy < -windowHeight/2 | yy > windowHeight/2;
% Mask image and show it
maskedImageEye = im2double(im);
mask = ~mask;
maskedImageEye(:,:,1) = maskedImageEye(:,:,1).*mask;
maskedImageEye(:,:,2) = maskedImageEye(:,:,2).*mask;
maskedImageEye(:,:,3) = maskedImageEye(:,:,3).*mask;

figure,imshow(maskedImageEye);hold on
rectangle('Position',BB2,'LineWidth',4,'LineStyle','-','EdgeColor','b');
title('Eyes Detection');


MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',24);

BB=step(MouthDetect,maskedImage);
BB = sortrows(BB, -2);
BB = BB(1,:);

%imshow(maskedImage); 
%for i = 1:size(BB,1)
% rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
%end
rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','r');
title('Mouth Detection');
hold off;

WB = GrayWorld(maskedImage);

%Checks which value that's lowest, either the original 
%image or the Gray World-image

%Checks whatever the origignal or the Gray World-image has the lowest value
%This value should be as close to one as possible
imDiv = GrayWorldDiv(maskedImage);
wbDiv = GrayWorldDiv(WB);

whiteBalanced = BestIm(imDiv, wbDiv, maskedImage, WB);

%Detect face in image im
detectedFace = FaceDetection(whiteBalanced);

WB2 = GrayWorld(maskedImageEye);

%Checks which value that's lowest, either the original 
%image or the Gray World-image

%Checks whatever the origignal or the Gray World-image has the lowest value
%This value should be as close to one as possible
imDiv = GrayWorldDiv(maskedImageEye);
wbDiv = GrayWorldDiv(WB2);

whiteBalanced2 = BestIm(imDiv, wbDiv, maskedImage, WB2);

%whiteBalanced2 = histeq(whiteBalanced2);

% FEATURES DETECTION: Eye map and Mouth map
%--------------------------------------------------------------------------
%Use only the detected face when creating the eyeMaps
%Create eye maps
eyeMapC = createEyeMapC(whiteBalanced2); %Chrominance
eyeMapL = createEyeMapL(whiteBalanced2); %Luminance

%Combine the eye maps
eyeMap = eyeMapC.*eyeMapL;

%Create mouthMap, not yet used
%mouthMap = createMouthMap(detectedFace);

%eyeMap = imcrop(eyeMap, [ B1 B2 B3 B4 ] );
eyeMap = im2bw(eyeMap, 0.3);

se = strel('disk',2);
eyeMap = imclose(eyeMap,se);

eyeMap = imfill(eyeMap,'holes');

SE = strel('rectangle',[7 7]);
eyeMap = imerode(eyeMap,SE);
eyeMap = imerode(eyeMap,se);

eyeMap = imdilate(eyeMap,se);


figure,imshow(eyeMap)

stats = regionprops('table',eyeMap,'Centroid', 'MajorAxisLength','MinorAxisLength');

transIm = transformImage( eyeMap, whiteBalanced );

% CROP
%--------------------------------------------------------------------------
 %Crop all images to equal size
[row,col,~] = size(transIm);

transIm = double(rgb2gray(transIm));
%outIm = imcrop(transIm, [ ceil(col/2 - minCols/2) ceil(row/2 - minRows/2) (minCols-1) (minRows-1)] );

figure,imshow(im)
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/7;

hold on
viscircles(centers,radii);
%figure
hold off

minRows = 450;
minCols = 350;
outIm = zeros(minRows, minCols, 3);

outIm = imcrop(transIm, [ ceil(col/2 - minCols/2) ceil(row/2 - minRows/2) (minCols-1) (minRows-1)] );
id = match(outIm)

MouthMap = createMouthMap( detectedFace );
MouthMap = imcrop(MouthMap, [ B1 B2 B3 B4 ] );
MouthMap = im2bw(MouthMap, 0.3);
%figure,imshow(MouthMap)

% FACE ALIGNMENT
%--------------------------------------------------------------------------
%Use the maps to scale the image so all eyes are placed 
%in at the same place. The output image has the same size
%as the input image
%transIm = transformImage( eyeMap, whiteBalanced );


%figure,imshow(transIm)