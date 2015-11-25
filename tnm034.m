%Namn

function id = tnm034( im )
%FACE DETECTION AND FACE RECOGNITION
 
processedIm = preprocess(im);

%Use eigenfaces for recognition
%return the id of the image
%0 = no mathch
id = match(processedIm);

end

