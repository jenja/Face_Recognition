function white_balanced = GrayWorld( im )
% GRAY WORLD
%   This function estimates the illumination by looking at the
%   the average color and comparing it to gray. This is used to 
%   color balance the image.

d_im = im2double(im);

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

% Adjust the channels after the adjustment factors
for i=1:x
    for j=1:y
        d_im(i, j, 1) = d_im(i, j, 1)*aR;
        d_im(i, j, 2) = d_im(i, j, 2)*aG;
        d_im(i, j, 3) = d_im(i, j, 3)*aB;
    end
end

% Values over 1 get thresholded to max value of double (1)
d_im( d_im(:) > 1 ) = 1;

% Output
white_balanced = d_im;

end

