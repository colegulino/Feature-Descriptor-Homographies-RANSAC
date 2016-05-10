%% Description
% This script gets everything needed in order to get the panaorama for the
% stitching function
%% Get the images
img1 = imread('../data/incline_L.png');
img2 = imread('../data/incline_R.png');
im1d = im2double(rgb2gray(img1));
im2d = im2double(rgb2gray(img2));
%% Get the locs and the descs
[locs1, desc1] = briefLite(im1d);
[locs2, desc2] = briefLite(im2d);
%% Get the matches
ratio = 0.3;
[matches] = briefMatch(desc1, desc2, ratio);
%% Get the points for computing H
p1 = [];
p2 = [];
for i = 1:length(matches)
    p1 = [p1; locs1(matches(i,1),1:2)];
    p2 = [p2; locs2(matches(i,2), 1:2)];
end
%% Get H matrix
H2to1 = computeH(p1,p2)
%% Get panorama
panoImg = imageStitching(img1, img2, H2to1);
imshow(panoImg);
%save('../results/q5_2_pan.jpg', 'panoImg');