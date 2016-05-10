function [ locs, desc ] = computeBrief( im, GaussianPyramid, locsDoG, k, levels, compareX, compareY )
% CV Spring 2016 - Cole Gulino
% Generate the brief descriptors
% Inputs: 
%   im:                 RxC image
%   GaussianPyramid:    RxCxL gaussian pyramid based on the images
%   locsDoG:            Nx3 matrix where DoG Pyramid acheives local extrema
%   k:                  the multiplicative factor of sigma at each level, where sigma=sigma_0 k^l
%   levels:             vector specifying the levels of the pyramid
%   compareX:           x index for the comparison (columns) nbits x 1
%   compareY:           y index for the comparison (rows) nbits x 1
% Outputs:
%   locs:               mx3 matrix in form (x,y,level)
%   desc:               mxn matrix of stacked BRIEF descriptors
%% Get the BRIEF descriptors
locs = [];
desc = [];
for i = 1:size(locsDoG,1)
    % Determine if you cannot extract a full patch of the image
    if(locsDoG(i,1) + 9 > size(im,2))
        continue;
    elseif(locsDoG(i,1) - 9 < 1)
        continue;
    elseif(locsDoG(i,2) + 9 > size(im,1))
        continue;
    elseif(locsDoG(i,2) - 9 < 1)
        continue;
    else
        levelI = find(levels == locsDoG(i,3));
        % If you can get a full patch
        locs = [locs; locsDoG(i,:)]; % store locs
        k = size(desc,1) + 1;
        for j = 1:size(compareX, 1)
            % Get (x,y) of compareX and compareY indexed at j
            X_x = mod(compareX(j), 9); % Get x of compareX(j)
            if(X_x == 0)
                X_x = 9;
            end
            Y_x = mod(compareY(j),9); % Get x of compareY(j)
            if(Y_x == 0)
                Y_x = 9;
            end
            X_y = floor(compareX(j) / 9); % Get y of compareX(j)
            if(mod(compareX(j), 9) == 0)
                X_y = X_y - 1;
            end
            Y_y = floor(compareY(j) / 9); % Get y of compareY(j)
            if(mod(compareY(j),9) == 0)
                Y_y = Y_y - 1;
            end
            if(GaussianPyramid(locsDoG(i,2) + X_y, locsDoG(i,1) + X_x, levelI) < ...
                GaussianPyramid(locsDoG(i,2) + Y_y, locsDoG(i,1) + Y_x, levelI))
                desc(k,j) = 1;
            else
                desc(k,j) = 0;
            end
        end
    end
end
end

