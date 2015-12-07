function histEQ = hist( im )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[X, map] = rgb2ind(im, 255);
newmap = histeq(X, map); 
histEQ = ind2rgb(X,newmap);


end

