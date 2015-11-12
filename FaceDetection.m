function Masked_Face = FaceDetection( im )
% Detectes faces in a picture and returns a new picture with the background
% masked.

% White Balance the picture
% TODO: Optimize later
balanced_im = whitebalance(im);

% Convert to doublr values
double_im = im2double(balanced_im);

% Get HSV color channels
[H, S, V] = rgb2hsv(double_im);

% A value that adapts to each picture
% NOTE: Just a trial and error function. Seems to make it a little better.
level = mean(mean(H))/2;

% Set wanted pixel (hoppfully the face) values to black (0)
% NOTE: The threshols values comes from trial and error.
%H( H < 0.11 | H > 0.6 ) = 0;
H( H < 0.11 | H > (0.95-level)) = 0;
%figure, imshow(H)

% Truns the image pixels to binary values
% The face is white and the rest is black
faceMask = H < 0.1;
%figure, imshow(faceMask)

% Shapes for dilate and erosion
se = strel('disk', 1);
se2 = strel('disk', 3);
se3 = strel('disk', 2);

% Expands cracks and removes noise
faceMask = imdilate(faceMask, se);
faceMask = imerode(faceMask, se2);
%figure, imshow(faceMask)

% Remove holes that can aqure in the face
MorphFace = imfill(faceMask, 'holes');
figure, imshow(MorphFace)

% Removes pixels outside the face
MorphFace = imerode(MorphFace, se);
MorphFace = imerode(MorphFace, se2);
%figure, imshow(MorphFace)
 
% Convert to RGB and seperate the channels
RGB = hsv2rgb(HSV);
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

% Segmentation
R(MorphFace ~= 1) = 0;
G(MorphFace ~= 1) = 0;
B(MorphFace ~= 1) = 0;

% Return RGB-chanels to one picture
Masked_Face = cat(3, R, G, B);

end

