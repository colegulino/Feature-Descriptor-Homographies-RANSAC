function [ PrincipalCurvature ] = computePrincipalCurvature( DoGPyramid )
% CV Spring 2016 - Cole Gulino
% Get the curvature ratios for points in DoG pyramid
% Inputs: 
%   DoGPyramid:         RxCxL-1 created by differencing the GaussianPyramid
% Outputs:
%   PrincipalCurvature: RxCxL-1 matrix of curvature ratios
thetar = 12; % Principal curvature threshold
%% Get the gradients of the pixels
[Dx, Dy] = gradient(DoGPyramid);
[Dxx, Dxy] = gradient(Dx);
[Dxy, Dyy] = gradient(Dy);
%% Get the principal curvature 
PrincipalCurvature = zeros(size(DoGPyramid,1), size(DoGPyramid,2), size(DoGPyramid,3));
for k = 1:size(DoGPyramid,3) % iterate over the layers
    for i = 1:size(DoGPyramid,1) % iterate over rows of image
        for j = 1:size(DoGPyramid,2) % iterate over the columns of image
            H = [Dxx(i,j,k) Dxy(i,j,k); Dxy(i,j,k) Dyy(i,j,k)]; % Get Hessian
            % Get the principal curvature
            R = ((trace(H))^2) / det(H);
            if(R > thetar) % Check threshold
                R = thetar;
            end
            PrincipalCurvature(i,j,k) = R;
        end
    end
end
end

