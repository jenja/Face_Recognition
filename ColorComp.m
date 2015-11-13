function NewIm = ColorComp( im )

% NOT WORKING YET
% To be seen if we need it later

I = im2double(im);
HSV = rgb2hsv(I);
V = HSV(:,:,3);
V = V(:);

[X, Y, Z] = size(im);

OneArr = reshape(im(:,:), [1, (X*Y*Z)]);
OneArr = sort(OneArr);

[A B] = size(OneArr)



I2 = im2double(im);
HSV = rgb2hsv(I2);
V = HSV(:,:,3);
V = V(:);
V = sort(V);

FiveProcent = V*0.5

V = V(1:FiveProcent)
Vmin = min(V)

OneArr = OneArr(1:FiveProcent);

AR = max(OneArr(:, 1))/min(OneArr(:, 1));
AG = max(OneArr(:, 2))/min(OneArr(:, 2));
AB = max(OneArr(:, 3))/min(OneArr(:, 3));

avgR = sum(AR)/FiveProcent;
avgG = sum(AG)/FiveProcent;
avgB = sum(AB)/FiveProcent;

avgGray = (avgR + avgG + avgB)/3;

aR = avgGray/avgR;
aG = avgGray/avgG;
aB = avgGray/avgB;

for i = 1:X
    for j = 1:Y

    NewIm = im(i, j, 1)*aR;
    NewIm = im(i, j, 2)*aG;
    NewIm = im(i, j, 3)*aB;

    end
end

NewIm 

imshow(NewIm)

end

