function transIm = transformImage( bweyeMap, im )
% TRANSFORM IMAGE
%   Transform the image, inputs are the image and the eye map. 
%   The transformations is rotation, rotation and scaling

% Get size of row and column
[~, col] = size(bweyeMap);

% Find circles in the images
[centers, radii, ~] = imfindcircles(bweyeMap,[1 100]);

TableStats = centers;
TableStats(:, 3) = radii;
TableStats = sortrows(TableStats, 1);

% Varibales for left and right eye
leftEye = TableStats(1, :);
rightEye = TableStats(end, :);

% Lefteyes x-value and the edge om the image in x-led 
lefteye2egde = leftEye;
lefteye2egde(1,2) = col;

% Vector from left to right eye
rlVec = rightEye - leftEye;
rlVec(1,3) = 0;

% Vector from Lefteyes x-value and to the edge om the image in x-led
leVec = lefteye2egde - leftEye;
leVec(1,3) = 0;


% Prefered lenght between the eyes 
prefLenght = 70;

% Scalefactor
eyeScale = rlVec(1,1)/prefLenght;

% Scale the image
scaleIm = imresize(im, eyeScale);

SBW = imresize(bweyeMap, eyeScale);


% Calculate the angle it need to rotare to get the eyes side by side
theta = atan2(norm(cross(rlVec, leVec)),dot(rlVec, leVec));

% If the rotation is clockwise
if dot(rlVec,leVec) < 0
     theta = -theta;
end

% Rorate image
rotIm = imrotate(scaleIm,theta, 'bilinear', 'crop');

SRBW = imrotate(SBW,theta, 'bilinear', 'crop');


[SRcenters, SRradii, ~] = imfindcircles(SRBW,[1 100]);

SRTableStats = SRcenters;
SRTableStats(:, 3) = SRradii;
SRTableStats = sortrows(SRTableStats, 1);

[SRrow, SRcol] = size(SRBW);

% Varibales for left and right eye
leftEye = SRTableStats(1, :);
rightEye = SRTableStats(end, :);

% Find the koordinate of the midpoint between the eyes
SReyeMid = round(leftEye + (rightEye - leftEye)/2);

% Calculate how many pixels it shuld move in x- and y-led
SReyeMoveX = round(SRcol/2) - round(SReyeMid(1,1)); 
SReyeMoveY = round(SRrow/2) - round(SReyeMid(1,2));

% Translate the midpoint of the eye to the middle of the image
transIm = imtranslate(rotIm,[round(SReyeMoveX), round(SReyeMoveY)]);


end
