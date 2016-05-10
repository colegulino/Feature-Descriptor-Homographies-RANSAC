function [ H2to1 ] = computeH( p1, p2 )
% CV Spring 2016 - Cole Gulino
% Compute the homography matrix between a sets of corresponding points
% Inputs: 
%   p1:                 2xN matrix of corresponding (x,y) coors b/w images
%   p2:                 2xN matrix of corresponding (x,y) coors b/w images
% Outputs:
%   H2to1:              3x3 matrix encoding homography
%% Get the A matrix
A = [];
for i = 1:size(p1,1)
    A = [A; [p2(i,1), p1(i,2), 1, 0, 0, 0, -p2(i,1)*p1(i,1), -p2(i,2)*p1(i,1), -p1(i,1)]];
    A = [A; [0, 0, 0, p2(i,1), p2(i,2), 1, -p2(i,1)*p1(i,2), -p2(i,2)*p1(i,2), -p1(i,2)]];
end
%% Get the eigenvalues and eigenvectors of the matrix A
[U, S, V] = svd(A);
%% Get the H matrix
h = V(:,end);
k = 1;
for i = 1:3
    for j = 1:3
        H2to1(i,j) = h(k);
        k = k + 1;
    end
end
H2to1 = H2to1 / H2to1(3,3);
end