function transIm = transformImage( bweyeMap, im )
% TRANSFORM IMAGE
%   Transform the image, inputs are the image and the eye map. 
%   The transformations is rotation, rotation and scaling


% Get size of row and column
[row, col] = size(bweyeMap);

% Find circles
stats = regionprops(bweyeMap,'Centroid', 'MajorAxisLength','MinorAxisLength');

% Sort table by eyesize
TableStats = sortrows(struct2table(stats), 3, 'descend');
TableStats = sortrows(TableStats(1:2, :), 1);

% Array of the eyes
eyeArray = round(table2array(TableStats(1:2, 1)));

% Varibales for left and right eye
leftEye = eyeArray(1, :);
rightEye = eyeArray(2, :);

% Find the koordinate of the midpoint between the eyes
eyeMid = round(leftEye + (rightEye - leftEye)/2);

% Calculate how many pixels it shuld move in x- and y-led
eyeMoveX = round(col/2) - round(eyeMid(1,1)); 
eyeMoveY = round(row/2) - round(eyeMid(1,2));

% Translate the midpoint of the eye to the middle of the image
imTrans = imtranslate(im,[round(eyeMoveX), round(eyeMoveY)]);

% Lefteyes x-value and the edge om the image in x-led 
lefteye2egde = leftEye;
lefteye2egde(1,2) = col;

% Vector from left to right eye
rlVec = rightEye - leftEye;
rlVec(1,3) = 0;
% Vector from Lefteyes x-value and to the edge om the image in x-led
leVec = lefteye2egde - leftEye;
leVec(1,3) = 0;
% Calculate the angle it need to rotare to get the eyes side by side
theta = atan2(norm(cross(rlVec, leVec)),dot(rlVec, leVec));

% If the rotation is clockwise
if dot(rlVec,leVec) < 0
     theta = -theta;
end

% Rorate image
rotim = imrotate(imTrans,theta, 'bilinear', 'crop');

% Prefered lenght between the eyes 
prefLenght = 50;

% Scalefactor
eyeScale = rlVec(1,1)/prefLenght
%imshow(rotim)

% Scale the image
transIm = imresize(rotim, eyeScale);
%transIm = imresize(rotim, eyeScale, 'bicubic');

end
