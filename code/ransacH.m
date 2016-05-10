function [ bestH ] = ransacH( matches, locs1, locs2, nIter, tol )
% CV Spring 2016 - Cole Gulino
% Generate H using RANSAC
% Inputs: 
%   matches:              px2 matrix where col1 is desc1, col2 is desc2 
%   locs1:                mx3 matrix in form (x,y,level)
%   locs2:                mx3 matrix in form (x,y,level)
%   nIter:                Number of iterations to run RANSAC for
%   tol:                  tolerance for point to be an inlier
% Outputs:
%   bestH:                3x3 matrix encoding homography
if nargin < 4
    nIter = 1000;
    tol = 10;
end
if nargin < 5
    tol = 10;
end
img1 = imread('../data/incline_L.png');
img2 = imread('../data/incline_R.png');
im1d = im2double(rgb2gray(img1));
im2d = im2double(rgb2gray(img2));
%% Run the RANSAC algorithm in order to generate the best possible H matrix
rng(0, 'twister'); % Initialize random number generator
mostIn = 0;
bestH = [];
bestInliersP1 = [];
bestInliersP2 = [];
for i = 1:nIter % Run for certain iterations
    % Get a random match
    no_random = 8;
    randI = randi([1, size(matches,1)],1,no_random);
    % Compute the H for the point match
    p1 = locs1(matches(randI,1), 1:2);
    p2 = locs2(matches(randI,2), 1:2);
    H = computeH(p1,p2);
    % Count the number of inliers
    inliersP1 = [];
    inliersP2 = [];
    no_in = 0;
    for j = 1:size(matches,1)
        p1 = [];
        p2 = [];
        p1(1,1) = locs1(matches(j,1), 1);
        p1(1,2) = locs1(matches(j,1), 2);
        p1(1,3) = 1;
        p2(1,1) = locs2(matches(j,2), 1);
        p2(1,2) = locs2(matches(j,2), 2);
        p2(1,3) = 1;
        p_warped = H*p2'; % warp the second point
        p_warped = p_warped / p_warped(end); % normalize it
        score = norm(p1' - p_warped,2); % compute difference
        if(score < tol)
            no_in = no_in + 1;
            inliersP1 = [inliersP1; p1(1:2)];
            inliersP2 = [inliersP2; p2(1:2)];
        end
    end
    if(no_in > mostIn)
        mostIn = no_in;
        bestInliersP1 = inliersP1;
        bestInliersP2 = inliersP2;
        bestH = H;
    end
end
%% Use the best inliers to get the new bestH
bestH = computeH(bestInliersP1, bestInliersP2);
end

