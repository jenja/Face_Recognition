function transIm = transformImage( map, im )
% Transform the image 
%   The transformations is rotation, rotation and scaling

% Cinvert to binary image
bweyeMap = im2bw(map, 0.3);

% Get size of row and column
[row, col] = size(bweyeMap);

% Remove everyting over the eyes
bweyeMap(1:(floor(row/4)), :) = 0;
bweyeMap(floor(2*row/4):row, :) = 0;

figure
imshow(bweyeMap)

% Remove everyting under the eyes
% bweyeMap(:, 1:(floor(col/2 - 100))) = 0;
% bweyeMap(:, floor(col/2 + 100):col) = 0;


se = strel('disk', 1);
se2 = strel('disk', 3);

% removes noise and expand
bweyeMap = imerode(imerode(imerode(imerode(bweyeMap, se), se), se), se2);
bweyeMap = imdilate(bweyeMap, se);

% Find circles
stats = regionprops('table',bweyeMap,'Centroid', 'MajorAxisLength','MinorAxisLength');

% Sort table by eyesize
table = sortrows(stats, 3, 'descend');
table = table(1:2, :)

% Array of the eyes
eyeArray = sort(round(table2array(table(1:2, 1))));

leftEye = eyeArray(1, :);
rightEye = eyeArray(2, :);

% Find the koordinate of the midpoint between the eyes
eyeMid = round(leftEye + (rightEye - leftEye)/2);

% Calculate how many pixels it shuld move in x- and y-led
eyeMoveX = round(col/2) - round(eyeMid(1,1)); 
eyeMoveY = round(row/2) - round(eyeMid(1,2));

% Translate the midpoint of the eye to the middle of the image
imTrans = imtranslate(im,[round(eyeMoveX), round(eyeMoveY)]);

%[X, Y, ~] = size(imTrans)

cropline = sqrt(pow2(eyeMoveX + eyeMoveY))

%imTrans =  imcrop(imTrans, [eyeMid(1,1) eyeMid(1,2) cropline*2 cropline*2.5]);

%[X, Y, ~] = size(imTrans)

% Lefteyes x-value and the edge om the image in x-led 
lefteye2egde = leftEye;
lefteye2egde(1,2) = col;

% Vector from left to right eye
rlVec = rightEye - leftEye;
% Vector from Lefteyes x-value and to the edge om the image in x-led
leVec = lefteye2egde - leftEye;

% Calculate the angle it need to rotare to get the eyes side by side
costheta = dot(rlVec,leVec)/(norm(rlVec)*norm(leVec));
theta = acos(costheta);

% Rorate image
rotim = imrotate(imTrans,-theta, 'bilinear', 'crop');

% Prefered lenght between the eyes 
prefLenght = 100;

% Scalefactor
eyeScale = rlVec(1,1)/prefLenght;

% Scale the image
transIm = imresize(rotim, eyeScale, 'bicubic');

% [X, Y, ~] = size(transIm)
% 
% cropline = sqrt(pow2(eyeMoveX + eyeMoveY))
% 
% transIm =  imcrop(transIm, [col/2-60 row/2 cropline*2 cropline*2.5]);
% 
% [X, Y, ~] = size(transIm)


%imshow(transIm)

% subplot(1,4,1);imshow(WB);
% title('Orginal')
% subplot(1,4,2);imshow(imTrans);
% title('Trans')
% subplot(1,4,3);imshow(rotim);
% title('Rot')
% subplot(1,4,4);imshow(transIm);
% title('Scale')


end

