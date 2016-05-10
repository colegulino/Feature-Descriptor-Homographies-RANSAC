function [ panoImg ] = imageStitching( img1, img2, H2to1 )
% CV Spring 2016 - Cole Gulino
% Create a stitched image
% Inputs: 
%   img1:                 image to be warped to
%   img2:                 image to be warped to fit im1
% Outputs:
%   panoImg:              image, of img1 and img2 stitched together
%% Warp img1 and img2
% Create your masks
out_size = [827 1280];
mask1 = zeros(size(img1, 1), size(img1,2));
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));
mask1 = warpH(mask1, [1 0 0; 0 1 0; 0 0 1], out_size);
%im2double(mask1);
mask2 = warpH(mask1, H2to1, out_size);
%im2double(mask2);
% Get the images
img1 = warpH(img1, [1 0 0; 0 1 0; 0 0 1], out_size);
%im2double(img1);
img2 = warpH(img2, H2to1, out_size);
%img2double(img2);
panoImg = max(img1, img2);
imagesc(panoImg); % Visualize the image
%% Save the files
imwrite(panoImg, '../results/q5_1.jpg'); % Save the image
save('../results/q5_1.mat', 'H2to1');
end

