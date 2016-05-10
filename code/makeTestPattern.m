function [ compareX, compareY ] = makeTestPattern( patchWidth, nbits )
% CV Spring 2016 - Cole Gulino
% Generate a difference of gaussians for an image
% Inputs: 
%   patchWidth:         Size of image patch to test on
%   nbits:              Number of test pairs
% Outputs:
%   compareX:           x index for the comparison (columns) nbits x 1
%   compareY:           y index for the comparison (rows) nbits x 1
%% Generate the x and y values for comparison
% Use method 1 in the paper
% source: http://www.mathworks.com/help/matlab/math/floating-point-numbers-within-specific-range.html
rng(0, 'twister'); % Initialize the random number generator
min = 1;
max = 82;
compareX = zeros(nbits,1); % Preallocate compareX
compareY = zeros(nbits,1); % Preallocate compareY
for i = 1:nbits
    compareX(i) = floor((max - min)*rand(1,1) + min);
    compareY(i) = floor((max - min)*rand(1,1) + min);
end
%% Store compareX and compareY
save('../results/testPattern.mat', 'compareX', 'compareY');
end