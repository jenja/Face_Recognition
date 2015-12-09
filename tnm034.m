function [id, winner] = tnm034( im )
% FACE DETECTION AND FACE RECOGNITION
%   This function detects the face of the input image
%   and preprocess it for recognition with a set of images.
%   The result will output as an variable between 1 - 16.
%close all
%Process the image for recognition, this includes
%face detection, features detection, face alignment
%and cropping the image
im = imrotate(im, 5);

processedIm = preprocess(im);

%Use eigenfaces for recognition
[id, winner] = EFmatch(processedIm);

%Use LPQ for recognition
% [id, winner] = LPQmatch(processedIm);

%return the id of the image
%0 = no match
end

