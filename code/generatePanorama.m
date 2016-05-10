function [ im3 ] = generatePanorama( im1, im2 )
% CV Spring 2016 - Cole Gulino
% Create a stitched image
% Inputs: 
%   im1:                 image to be warped 
%   im2:                 image to be warped to fit im1
% Outputs:
%   im3:                 panorama image 
%% Process the image
im1d = im2double(rgb2gray(im1));
im2d = im2double(rgb2gray(im2));
%% Get the locations and descriptors
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
nIter = 1000;
tol = 10;
bestH = ransacH(matches, locs1, locs2, nIter, tol);
%% Get the panorama image
im3 = imageStitching_noClip(im1, im2, bestH);
imshow(im3); % Show the panorama
end

