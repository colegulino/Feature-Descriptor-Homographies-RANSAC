%% Description for testMatch.m
%   Test two images against each other using plotMatches and briefMatches
%   provided functions.
%% Get the descriptors for the two images
im1 = imread('../data/pf_scan_scaled.jpg');
im2 = imread('../data/pf_stand.jpg');
im1 = im2double(im1);
im2 = im2double(rgb2gray(im2));
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
%% Get the matches
[matches] = briefMatch(desc1, desc2);
%% Plot the matches
plotMatches(im1, im2, matches, locs1, locs2);