% TNM034 - ADVANCED IMAGE PROCESSING
% Isabell Jansson            isaja187
% Ronja Grosz                rongr946
% Christoffer Engelbrektsson chren574
% Jens Jakobsson             jenja698
% 2015-12-11
%------------------------------------

function id = LPQmatch(im)
% MATCH
%   Match image with the database and return an integer.
%   id = 0 if no match
%   id = index if match

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
       winner = near;
       index = i;
   end
end

%Threshold may not be correct, but works fine for now
threshold = 5.0;
if winner > threshold
    index = 0;
end

id = index;

end