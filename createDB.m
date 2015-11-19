%Run the first time, or if changing the DB,
%to create the training set. This will create 
%two matrices with weights and 
%eigenvectors which are loaded into match.m

close all;

M = 14;
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

%Calculate how much each image differs from the average
for i = 1:M
   F(:,i) = (imgDB(:,i) - avgFace)/sqrt(M); 
end

%SVD
%U: Eigenvectors, sorted
%S: Eigenvalues in the diagonal, sorted
[U,S,~] = svd(F,0);

%Calculate the weigths
w = (imgDB'*U)';

%Save weigths to a file
save('weights.mat','w');
save('eigenvectors.mat', 'U');