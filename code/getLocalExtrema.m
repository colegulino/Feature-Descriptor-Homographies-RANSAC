function [ locsDoG ] = getLocalExtrema( DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r )
% CV Spring 2016 - Cole Gulino
% Detect the local extrema
% Inputs: 
%   DoGPyramid:         RxCxL-1 created by differencing the GaussianPyramid
%   DoGLevels:          L-1 vector specifying the levels of DoGPyramid
%   PrincipalCurvature: RxCxL-1 matrix of curvature ratios
%   th_contrast:        Threshold to remove local extrema    
%   th_r:               Threshold to remove any edge-like points
% Outputs:
%   locsDoG:            Nx3 matrix where DoG Pyramid acheives local extrema
locsDoG = [];
%% Get the local extrema
for i = 1:size(DoGPyramid,3) % Loop over the DoG levels
    max = imregionalmax(DoGPyramid(:,:,i)); % Get maximum
    min = imregionalmin(DoGPyramid(:,:,i)); % Get minimum
    % Get the indices and run threshold checking
    [max_r, max_c] = find(max);
    [min_r, min_c] = find(min);
    for j = 1:size(max_r,1) % Loop over maximum extrema
        if(DoGPyramid(max_r(j), max_c(j), i) < th_contrast) % Threshold contrast
            continue;
        end
        if(PrincipalCurvature(max_r(j), max_c(j),i) >= th_r) % Threshold curvature
            continue;
        end
        locsDoG(size(locsDoG,1)+1, 1:3) = [max_c(j) max_r(j) DoGLevels(i)];
    end
    for j = 1:size(min_r,1) % Loop over maximum extrema
        if(DoGPyramid(min_r(j), min_c(j), i) < th_contrast) % Threshold contrast
            continue;
        end
        if(PrincipalCurvature(min_r(j), min_c(j),i) >= th_r) % Threshold curvature
            continue;
        end
        locsDoG(size(locsDoG,1)+1, 1:3) = [min_c(j) min_r(j) DoGLevels(i)];
    end
end
end

