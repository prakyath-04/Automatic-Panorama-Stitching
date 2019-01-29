function [panorama] = main(folder)
% clear all;close all;clc;
warning off all;

%% Reading images from the folder
disp("Reading images from the folder...");
% folder = '../glacier4';
img_arr = readFolder(folder);

%% Preprocessing the images.
disp("Preprocessing Images...");
img_arr = preprocessing(img_arr);
k = size(img_arr,2);

%% Get Features.
feat = {};points = {};
disp('Extracting SURF features...');
for i = 1:k
    [points{i},feat{i}] = getSURFFeatures(img_arr{i});
end

%% Finding all possible image matches
disp("Finding the image matches...");
[matches,pairs] = image_match(points,feat);
G = graph(pairs(:,1),pairs(:,2));
plot(G);
%% Finding the different panoramas
disp("Finding the different number of panoramas")
[pairs_final,matches_final,N] = connected_comp(pairs,k,matches);
panorama = {};
%% Running the code for different possible panoromic images
for i = 1:size(matches_final,2)
    fprintf('Panorama %d \n',i);
    current_pair = pairs_final{i};
    current_match = matches_final{i};
    %% RANSAC algorithm to find inlier points
    disp("Running RANSAC for matched images...");
    [inliers] = RANSACupdated(current_match,current_pair);
%     plot_SURF(img_arr,current_match,current_pair,inliers);
    
    %% Ordering the Images
    disp("Ordering the images...");
    [inliers_order,best_order] = find_order_update(inliers,current_pair);
%     figure;
%     G1 = graph(best_order(:,1),best_order(:,2));
%     plot(G1);
    
    % Bundle Adjustment
    disp("Solving for homographies...");
    [homo]=bun(best_order,inliers_order,N(i),k);
    
    %% image stitching
    disp("Stitching images...");
    panorama{i} = stitch(img_arr,homo,best_order);
    figure;  
    imshow(panorama{i});
    
end
end
