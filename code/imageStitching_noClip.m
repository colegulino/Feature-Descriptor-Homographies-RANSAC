function [ panoImg ] = imageStitching_noClip( img1, img2, H2to1 )
% CV Spring 2016 - Cole Gulino
% Create a stitched image without clipping
% Inputs: 
%   img1:                 image to be warped to
%   img2:                 image to be warped to fit im1
% Outputs:
%   panoImg:              image, of img1 and img2 stitched together
%% Generate the M matrix to scale and translate
W = 1280; % width of out_size
imW = size(img1, 2);
imH = size(img1, 1);
H = floor(W*(imH/imW)); % height of out_size keeping aspect ratio
out_size = [W H];
off = 500;
p1 = [1, 1+off; 1,size(img1,2)+off; size(img1,1), 1+off; size(img1,1), size(img1,2)+off];
p2 = [1-off, 1; 1-off, W; H+off, 1; H+off, W];
M = computeH(p1, p2);
% Now go through the image to make sure that nothing is out of the frame,
% if so increase scale factor
%% Warp img1 and img2
imgW2 = warpH(img2, M*H2to1, out_size);
imgW1 = warpH(img1, M, out_size);
panoImg = max(imgW1, imgW2);
imagesc(panoImg); % Visualize the image
%% Save the files
imwrite(panoImg, '../results/q5_2_pan.jpg'); % Save the image
end