function id = LPQmatch(im)
% MATCH
%   Match image with the database and return an integer.
%   id = 0 if no match
%   id = index if match

imshow(im);

%Load training set
load LPQweights.mat
load phasevectors.mat

minRows = 450;
minCols = 350;
area = 10;
H = zeros(256, minRows/area * minCols/area);

%Calculate through LPQ
j = 0;
for x = 1:area:minRows - area
    for y = 1:area:minCols - area
        j = j + 1;
        H(:,j) = (lpq(im(x:x+area, y:y+area)))'; 
    end
end

wImg = ((reshape(H', [], 1))'*U)';

index = 0;
winner = 99999;
for i = 1:16
   near = wImg - w(:,i);
   near = sqrt(near'*near);
   if near < winner 
       near
       winner = near;
       index = i;
   end
end

%Threshold may not be correct, but works fine for now
threshold = 1000;
if winner > threshold
    index = 0;
end

id = index;

end