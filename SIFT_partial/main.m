% function [panorama] = main(folder)
clear all;close all;clc;
run('vlfeat-0.9.21-bin/vlfeat-0.9.21/toolbox/vl_setup.m');
%% Reading images from the folder
disp("Reading images from the folder...");
folder = '../glacier4';
img_arr = readFolder(folder);

%% Preprocessing the images.
disp("Preprocessing Images...");
img_arr = preprocessing(img_arr);
%% Get Features.
n = size(img_arr,2);
feat = {};desc = {};
disp('Extracting SIFT features...');
for i = 1:n
    [feat{i},desc{i}] = getSIFTfeatures(img_arr{i});
end

%% Finding all possible image matches
disp("Finding the image matches...");
[pairs,pair_matches] = image_match(feat,desc);


% RANSAC algorithm to find inlier points
disp("Running RANSAC for matched images...");
inliers = RANSAC(pair_matches);

plot_SIFT(img_arr,pair_matches,pairs,inliers);
% end
