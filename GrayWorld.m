function white_balanced = GrayWorld( im )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

d_im = im2double(im);

% Convert to HSV
HSV = rgb2hsv(im);
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);

% Change it to a array
V2 = V(:);

% Sort the array
V2 = sort(V2, 'descend' );

% Number of pixels to be calculated with.
procent = 0.05;
pixels = floor(size(V2, 1)*procent);

% The lowest value of the pixels. 
Threshold = V2(pixels);

% Making a mask
Mask=V>Threshold;

% A check to be sure the numbner of pixels is correct 
%[r,c, z]=size(im);
%pro = sum(sum(Mask))/(r*c);


% Mask the different channels
H(~Mask) = 0;
S(~Mask) = 0;
V(~Mask) = 0;

% Stich the channels back to gather
Masked_Face = cat(3, H, S, V);

% Convert back to RGB
newrgb = hsv2rgb(Masked_Face);


% Calculate the average of the pixels in the channels
AR = mean(mean(newrgb(:,:,1)));
AG = mean(mean(newrgb(:,:,2)));
AB = mean(mean(newrgb(:,:,3)));

% A value to see how much it diviates from 1.
% NOTE: Do we want it to white balance every time of use this value to
% check if it is needed?
div = max( max(AR, AG), AB) / min( min(AR, AG), AB); 


% Average value for red, greed and blue 
avgR = mean(mean(d_im(:,:,1)));
avgG = mean(mean(d_im(:,:,2)));
avgB = mean(mean(d_im(:,:,3)));

% Average gray value
avgGrey = (avgR + avgG + avgB)/3;

% Adjustiment factors
aR = avgGrey/avgR;
aG = avgGrey/avgG;
aB = avgGrey/avgB;

[x, y, z]=size(im);

% Adjustiment the channels
for i=1:x
    for j=1:y
        d_im(i, j, 1) = d_im(i, j, 1)*aR;
        d_im(i, j, 2) = d_im(i, j, 2)*aG;
        d_im(i, j, 3) = d_im(i, j, 3)*aB;
    end
end

% Values over 1 get thresholded to max value of double (1)
d_im( d_im(:) > 1 ) = 1;

white_balanced = d_im;

end

