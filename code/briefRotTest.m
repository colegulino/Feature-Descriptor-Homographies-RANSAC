%% Description for briefRotTest.m
% Run a script that takes the chicken broth model example image and then
% rotates it by 10 degrees consecutively and plots a bar chart with the
% number of correct matches for each rotation angle.
%% Read the image
im1 = imread('../data/model_chickenbroth.jpg');
im2 = imread('../data/model_chickenbroth.jpg');
im1 = im2double(rgb2gray(im1));
im2 = im2double(rgb2gray(im2));
%% Rotate the image and test
no_matches = [];
rots = [];
for i = 0:10:350
    imrot = imrotate(im2, i); % rotate second image
    % Get the locations and descriptors
    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(imrot);
    [matches] = briefMatch(desc1, desc2, 0.95); % Get matches
    %plotMatches(im1, imrot, matches, locs1, locs2); % Plot
    rots = [rots; i];
    no_matches = [no_matches; size(matches,1)];
end
%% Plot the matches in a bar chart
figure;
title('Number of Correct Matches vs Rotation Angle');
xlabel('Rotation Angle (Degs)');
ylabel('Number of Correct Matches');
bar(rots, no_matches);