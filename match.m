function id = match(im)
% MATCH
%   Match image with the database and return an integer.
%   id = 0 if no match
%   id = index if match

%Load training set
load weights.mat
load eigenvectors.mat

wImg = ((reshape(im, [], 1))'*U)';

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
threshold = 1000;
if winner > threshold
    index = 0;
end

id = index;

end