function out = featuresDetect( I )
%FEATURESDETECT Summary of this function goes here
%   Detailed explanation goes here

%To detect Mouth
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',30);
BB=step(MouthDetect,I);
figure,
imshow(I); hold on
for i = 1:size(BB,1)
 rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
end
title('Mouth Detection');
hold off;

%To detect Eyes
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB=step(EyeDetect,I);
figure,imshow(I);
rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
title('Eyes Detection');

end

