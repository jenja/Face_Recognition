% CREATE DATABASE
%   Run the first time, or if changing the DB,
%   to create the training set. This will create 
%   two matrices with weights and 
%   eigenvectors which are loaded into match.m

close all;


M = 16;
minRows = 450;
minCols = 350;
area = 10;
imgDB = zeros(minRows*minCols, M);
hDB = zeros(minRows/area * minCols/area * 256, M);
F = imgDB;
H = zeros(256, minRows/area * minCols/area);

% Read in all images from the database
% Preprocess them 
for i = 1:M
    if i < 10
        im = imread(sprintf('DB1/db1_0%d.jpg', i));
    else
        if i == 10
            % Ignore image, dont work right now
        else
            im = imread(sprintf('DB1/db1_%d.jpg', i));
        end
    end
   
    %Preprocess image 
    resIm =preprocess(im);
    [row,col,~] = size(resIm);

    %Make grayscale and resize the image to an array
    %resIm = reshape(resIm, [], 1);
    
    %Calculate through LPQ
    j = 0;
    for x = 1:area:minRows - area
        for y = 1:area:minCols - area
            j = j + 1;
            H(:,j) = (lpq(resIm(x:x+area, y:y+area)))'; 
        end
    end
    
    resH = reshape(H', [], 1);
    resIm = reshape(resIm, [], 1);
    
    %Save into imgDB, which will contain all images in DB1
    %Stored as arrays
    imgDB(:,i) = resIm;
    hDB(:,i) = resH;
    
end

%Calculate the average face
%avgFace = sum(imgDB,2)./M;

%Calculate how much each image differs from the average
%for i = 1:M
 %  F(:,i) = (imgDB(:,i) - avgFace)/sqrt(M); 
%end

%SVD
%U: Eigenvectors, sorted
%S: Eigenvalues in the diagonal, sorted
[U,S,~] = svd(hDB,0);

%Calculate the weigths
w = (hDB'*U)';

%Save weigths to a file
save('weights.mat','w');
save('eigenvectors.mat', 'U');
