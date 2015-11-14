%Change this to a function later on...
%Calculates the eigenfaces of the images in the DB
%Project a query image onto the eigenfaces
%Compare have much it differs
%Should return the eigenface with 
%the smallest euklidian distance, but not working yet
close all;

M = 3;
p = 303*241;
imgDB = zeros(p, M);
F = imgDB;

% Read in all images from the database
% and make gray
for i = 1:M
    if i < 10
        imgDB(:,i) = reshape((rgb2gray(imread...
            (sprintf('ps/db1_0%d.jpg', i)))), [], 1);
    else
        imgDB(:,i) = reshape((rgb2gray(imread...
            (sprintf('ps/db1_%d.jpg', i)))), [], 1);
    end
end

%Calculate the average face
avgFace = sum(imgDB,2)./M;

%imshow(uint8(reshape(round(avgFace), 303, 241)));

%Calculate have much each image differs from the average
for i = 1:M
   F(:,i) = (imgDB(:,i) - avgFace)/sqrt(2); 
end

% figure 
% imshow(uint8(reshape(round(F(:,1)), 303, 241)));
% figure 
% imshow(uint8(reshape(round(F(:,2)), 303, 241)));
% figure 
% imshow(uint8(reshape(round(F(:,3)), 303, 241)));

%PCA - not working
% [u,~] = eig(F'*F);
% 
% d = (u*F')';
% 
% for i = 1:M 
% figure
% colormap gray
% imagesc(reshape(d(:,i),303,241)); 
% end
% 
% for i = 1:M
%     w(:,i) = (imgDB(:,3) - avgFace)./d(:,i);
%     q(i) = nansum(w(:,i));
% end


%SVD

[U,S,V] = svd(F,0);

for i = 1:M
    % Normalize to [0, 1]:
    minimum = min(U(:,i));
    maximum = max(U(:,i));
    range = maximum - minimum;
    array = (U(:,i) - minimum) ./ range;

    % Then scale to [0, 255]:
%     range =  255;
%     normalized = (array*range);

    %show
    figure
    colormap gray;
    imagesc(reshape(array,303,241));
    
end




