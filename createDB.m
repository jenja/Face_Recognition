%Run the first time, or if changing the DB,
%to create the training set. This will create 
%two matrices with weights and 
%eigenvectors which are loaded into match.m

close all;


M = 16;
minRows = 450;
minCols = 350;
imgDB = zeros(minRows*minCols, M);
F = imgDB;

% Read in all images from the database
% Preprocess them 
for i = 1:M
    if i < 10
        im = imread(sprintf('DB1/db1_0%d.jpg', i));
    else
        im = imread(sprintf('DB1/db1_%d.jpg', i));
    end
   
    %Preprocess image 
    resIm =preprocess(im);
    [row,col,~] = size(resIm);

    %Make grayscale and resize the image to an array
    resIm = reshape(resIm, [], 1);
    
    %Save into imgDB, which will contain all images in DB1
    %Stored as arrays
    imgDB(:,i) = resIm;
    
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