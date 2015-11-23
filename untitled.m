close all

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


MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',32);
BB1=step(MouthDetect,detectedFace);
%figure,

imshow(detectedFace); hold on
for i = 1:size(BB1,1)
 rectangle('Position',BB1(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
end
hold on
%To detect Eyes
%EyeDetectLeft = vision.CascadeObjectDetector('EyePairSmall');
EyeDetectLeft = vision.CascadeObjectDetector('LeftEye');
BB2=step(EyeDetectLeft,detectedFace);
%imshow(detectedFace);
rectangle('Position',BB2,'LineWidth',4,'LineStyle','-','EdgeColor','b');
title('Eyes Detection');
