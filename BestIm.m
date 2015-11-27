function im = BestIm( imDiv, wbDiv, im, WB )
% BEST IMAGE
%   Return the image - either the original of the Gray World
%   with the value closes to one.

% Put the vaules in an array
DivArr = [imDiv wbDiv];

% Find the value closest to 1 
[~,I] = min(abs(DivArr-1));

% The cloest value
LowestDiv = DivArr(I);

% If the closest value is from the Gray World-image then chose that image, 
% otherwise the original 
if LowestDiv == wbDiv
    im = WB;
end

end

