function [id, winner] = tnm034( im )
% FACE DETECTION AND FACE RECOGNITION
%   This function detects the face of the input image
%   and preprocess it for recognition with a set of images.
%   The result will output as an variable between 1 - 16.
%close all
%Process the image for recognition, this includes
%face detection, features detection, face alignment
%and cropping the image

% ill +30
% im = 1.3*im;
% im(im > 255) = 255;
% ill -30
% im = 0.7*im;
% +5% rot
% im = imrotate(im, 5);
% -5% rot
% im = imrotate(im, -5);
% +10 scale
% im = imresize(im, 1.1);
% -10 scale
im = imresize(im, 0.9);

processedIm = preprocess(im);

%Use eigenfaces for recognition
% [id, winner] = EFmatch(processedIm);

%Use LPQ for recognition
[id, winner] = LPQmatch(processedIm);

%return the id of the image
%0 = no match
end

