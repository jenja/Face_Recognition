function div = DivVal( im )
%Function to calculate the diviation from 1
%  If it diviated to much, ignore Gray world 

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

end

