function [inliers] = RANSAC(pair_matches)
n = size(pair_matches,2);
inliers = {};
for i = 1:n
    pair = pair_matches{i};
    pair1 = pair(:,:,1);
    pair2 = pair(:,:,2);
    [inliers_a,inliers_b] = estimateFundamentalMatrixRANSAC(pair1,pair2);
    inliers{i} = [inliers_a,inliers_b];
end
end