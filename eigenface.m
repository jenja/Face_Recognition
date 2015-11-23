%Change this to a function later on...
%Calculates the eigenfaces of the images in the DB
%Project a query image onto the eigenfaces
%Compare have much it differs
%Should return the eigenface with 
%the smallest euklidian distance, but not working yet
close all;

M = 16;
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
   F(:,i) = (imgDB(:,i) - avgFace)/sqrt(M); 
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
 
% for i = 1:M
%     %Show normalized eigenface
%     figure
%     imshow(reshape(U(:,i),303,241),[]);
% end

w = imgDB'*U;
% for i = 1:M
%     w(i,1) = (imgDB(:,1)-avgFace)./U(:,1);
% end
%  im = zeros(303*241,1);
% for i = 1:M
%     %reconstruct an image
%     figure
%     im = im + w(i,6)*U(:,i);
%     imshow(reshape(imcomplement(im./M),303,241),[]);
% end
% figure
% imshow(reshape(imgDB(:,6),303,241),[]);

% Find the closest match
inImg = imgDB(:,1);

wImg = w(:,16);

index = 0;
winner = 99999;
for i = 1:15
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








%%
%PCA 
% cov(F);
% C=F'*F;
% [V,D]=eig(C);
% [U,D]=eig(C);
% V=FU;
%  
% V=F*U;
% close all;
% U=V;
% for i = 1:M
%     %Show normalized eigenface
%     figure
%     imshow(reshape(U(:,i),303,241),[]);
% end

