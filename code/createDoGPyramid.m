function [ DoGPyramid, DoGLevels ] = createDoGPyramid( GaussianPyramid, levels )
% CV Spring 2016 - Cole Gulino
% Generate a difference of gaussians for an image
% Inputs: 
%   GaussianPyramid:    RxCxL gaussian pyramid based on the images
%   levels:             vector specifying the levels of the pyramid
% Outputs:
%   DoGPyramid:         RxCxL-1 created by differencing the GaussianPyramid
%   DoGLevels:          L-1 vector specifying the levels of DoGPyramid
%% Get the levels of the Difference of Gaussians
DoGLevels = levels(2:end);
%% Get the Differences of Gaussian Pyramid
DoGPyramid = zeros(size(GaussianPyramid,1), size(GaussianPyramid,2), size(GaussianPyramid,3)-1);
for i = size(GaussianPyramid,3):-1:2
    DoGPyramid(:,:,i-1) = GaussianPyramid(:,:,i) - GaussianPyramid(:,:,i-1);
end
end

