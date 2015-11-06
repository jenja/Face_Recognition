function id = ModHSV( im )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

sum = 0;

[X, Y, Z] = size(im);
Vmax = zeros(X,Y);
Vmin = zeros(X,Y);
H = zeros(X,Y);
S = zeros(X,Y);

R = im2double(im(:,:,1));
G = im2double(im(:,:,2));
B = im2double(im(:,:,3));

for i = 1:X
    for j = 1:Y
        Vmax(i,j) = max(im2double(im(i,j,:)));
        Vmin(i,j) = min(im2double(im(i,j,:)));
        
        if ( R(i,j) == Vmax(i,j) ) && ( G(i,j) > B(i,j) )
            H(i,j) = 60 * ( ( G(i,j) - B(i,j) ) / Vmax(i,j) - Vmin(i,j) );
        
        
        elseif  ( R(i,j) == Vmax(i,j) ) && ( G(i,j) < B(i,j) )
            H(i,j) = 60 * ( ( G(i,j) - B(i,j) ) / Vmax(i,j) - Vmin(i,j) ) + 360;
        
        
        elseif  G(i,j) == Vmax(i,j)
            H(i,j) = 60 * ( ( B(i,j) - R(i,j) ) / Vmax(i,j) - Vmin(i,j) ) + 120;
        
        
        elseif  B(i,j) == Vmax(i,j)
            H(i,j) = 60 * ( ( R(i,j) - G(i,j) ) / Vmax(i,j) - Vmin(i,j) ) + 240;
            
        else
            H(i,j) = -1;
            sum = sum + 1;
        end
        
        %if Vmax(i,j) == 0
        %   S(i,j) = 0;
        %else 
        %    S(i,j) = 1 - (Vmin(i,j)/Vmax(i,j));
        %end
            
    end

end

sum

% for i = 1:X
%     for j = 1:Y
%         
%         if Vmax(i,j) ~= 0
%             
%             S(i,j) = 1 - (Vmin(i,j)/Vmax(i,j));
%       
%         else 
%             S(i,j) = 0;
%         end
%             
%     end
% 
% end

S = 1 - (Vmin./Vmax);

imshow(H); figure; imshow(S); figure; imshow(Vmax); figure;

H = H(:);
S = S(:);
V = Vmax(:);

Kmean = kmeans([H S V], 2);


imshow(ind2rgb(reshape(Kmean, size(im,1), size(im, 2)), [0 0 1; 0 0.8 0]))

id = 1;

end



