% TNM034 - ADVANCED IMAGE PROCESSING
% Isabell Jansson            isaja187
% Ronja Grosz                rongr946
% Christoffer Engelbrektsson chren574
% Jens Jakobsson             jenja698
% 2015-12-11
%------------------------------------

function id = tnm034( im )
% FACE DETECTION AND FACE RECOGNITION
%   This function detects the face of the input image
%   and preprocess it for recognition with a set of images.
%   The result will output as an variable between 1 - 16.

%Process the image for recognition, this includes
%face detection, features detection, face alignment
%and cropping the image
processedIm = preprocess(im);

%Use eigenfaces for recognition
% id = EFmatch(processedIm);

%Use LPQ for recognition
id = LPQmatch(processedIm);

%return the id of the image
%0 = no match
end

