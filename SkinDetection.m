% TNM034 - ADVANCED IMAGE PROCESSING
% Isabell Jansson            isaja187
% Ronja Grosz                rongr946
% Christoffer Engelbrektsson chren574
% Jens Jakobsson             jenja698
% 2015-12-11
%------------------------------------

function Masked_Skin = SkinDetection( im )
% Detectes faces in a picture and returns a new picture with the background
% masked.

% Convert to doublr values
double_im = im2double(im);

% Get HSV color channels
[H, ~, ~] = rgb2hsv(double_im);

% A value that adapts to each picture
% NOTE: Just a trial and error function. Seems to make it a little better.
level = mean(mean(H))/2;

% Set wanted pixel (hoppfully the face) values to black (0)
% NOTE: The threshols values comes from trial and error.
H( H < 0.11 | H > (0.95-level)) = 0;

% Truns the image pixels to binary values
% The face is white and the rest is black
faceMask = H < 0.1;

% Shapes for dilate and erosion
se = strel('disk', 1);
se2 = strel('disk', 3);
se3 = strel('disk', 2);

% Expands cracks and removes noise
faceMask = imdilate(faceMask, se);
faceMask = imerode(faceMask, se2);

% Remove holes that can aqure in the face
MorphFace = imfill(faceMask, 'holes');

% Removes pixels outside the face
MorphFace = imerode(MorphFace, se);
MorphFace = imerode(MorphFace, se2);
 
% Convert to RGB and seperate the channelsilluminating
R = double_im(:,:,1);
G = double_im(:,:,2);
B = double_im(:,:,3);

% Segmentation
R(MorphFace ~= 1) = 0;
G(MorphFace ~= 1) = 0;
B(MorphFace ~= 1) = 0;

% Return RGB-chanels to one picture
Masked_Skin = cat(3, R, G, B);

end

