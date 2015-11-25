%Namn

function outIm = preprocess( im )
% PREPOCESS THE IMAGE

    minRows = 450;
    minCols = 350;
    outIm = zeros(minRows, minCols, 3);

    %White balance the image
    WB = GrayWorld(im);
    
    %Checks which value that's lowest of the original 
    %image or the Gray World-image
    imDiv = GrayWorldDiv(im);
    wbDiv = GrayWorldDiv(WB);
    
    whiteBalanced = BestIm(imDiv, wbDiv, im, WB);
    
    %Detect face in image im
    detectedFace = FaceDetection(whiteBalanced);
    
    %Use only the detected face when creating the eyeMaps
    %Create eye maps
    eyeMapC = createEyeMapC(detectedFace);
    eyeMapL = createEyeMapL(detectedFace);
    
    %Combine the eye maps
    eyeMap = eyeMapC.*eyeMapL;
    
    %Create mouthMap, not yet used
    %mouthMap = createMouthMap(detectedFace);
    
    %Use the maps to scale the image so all eyes are placed 
    %in at the same place. The output image has the same size
    %as the input image
    transIm = transformImage( eyeMap, whiteBalanced );
    
    
     %Crop all images to equal size
    [row,col,~] = size(transIm);
    
  
    transIm = double(rgb2gray(transIm));
    outIm = imcrop(transIm, [ ceil(col/2 - minCols/2) ceil(row/2 - minRows/2) (minCols-1) (minRows-1)] );

end

