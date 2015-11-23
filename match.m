% function id = match(im)
%match image with the database
%id = 0 if no match
%id = index if match
close all;
%Load training set
load weights.mat
load eigenvectors.mat

%REMOVE WHEN EVERYTHING WORKS
im = imread('ps/db1_14.jpg');

%im should be in grey scale, 
%Later on im will be preprocessed
%and this step is no longer needed
im = double(rgb2gray(im));

wImg = ((reshape(im, [], 1))'*U)';

v = zeros (303*241,1);
for i = 1:14
    %reconstruct an image
    figure
    v = v + w(i,14)'*U(:,i);
    imshow(reshape((v),303,241),[]);
end


index = 0;
winner = 99999;
for i = 1:14
   near = wImg - w(:,i);
   near = sqrt(near'*near);
   if near < winner 
       winner = near;
       index = i;
   end
end

threshold = 1000;
if winner > threshold
    index = 0;
end

id = index;

% end