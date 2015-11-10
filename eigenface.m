%Change this to a function later on...

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

imshow(uint8(reshape(round(avgFace), 303, 241)));

%Calculate have much each image differs from the average
for i = 1:M
   F(:,i) = (F(:,1) - avgFace)/sqrt(2); 
end



%
