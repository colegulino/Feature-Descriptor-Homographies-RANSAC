function [ locs, desc ] = briefLite( im )
% CV Spring 2016 - Cole Gulino
% Generate a difference of gaussians for an image
% Inputs: 
%   im:                 RxC grayscale image
% Outputs:
%   locs:               mx3 matrix in form (x,y,level)
%   desc:               mxn matrix of stacked BRIEF descriptors
%% Load parameters and test patterns
load('../results/testPattern.mat');
sigma0 = 1;
k = sqrt(2);
levels = [-1 0 1 2 3 4];
th_contrast = 0.03;
th_r = 12;
%% Get Keypoint locations
[locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r);
%% Compute set of BRIEF descriptors
[locs, desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareX, compareY);
end