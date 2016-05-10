function [ locsDoG, GaussianPyramid ] = DoGdetector( im, sigma0, k, levels, th_contrast, th_r )
% CV Spring 2016 - Cole Gulino
% Put all of Part 1 together
% Inputs: 
%   im:                 RxC image
%   sigma0:             the standard deviation of the blur at level 0
%   k:                  the multiplicative factor of sigma at each level, where sigma=sigma_0 k^l
%   levels:             vector specifying the levels of the pyramid
%   th_contrast:        Threshold to remove local extrema    
%   th_r:               Threshold to remove any edge-like points
% Outputs:
%   locsDoG:            Nx3 matrix where DoG Pyramid acheives local extrema
%   GaussianPyramid:    RxCxL gaussian pyramid based on the images
%% Get the Gaussian Pyramid
GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
%% Get the Difference of Gaussians
[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
%% Get the Principal Curvature
PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
%% Get the local extrema
locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r);
end

