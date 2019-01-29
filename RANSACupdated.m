function [inliers] = RANSACupdated(matches,pairs)
n = size(matches,1);
%%%% Col one shows best image and col 2 shows the number of inliers.
inliers = {};
for i = 1:n
    pair1 = matches{i,1};
    pair2 = matches{i,2};
    [inliers_a,inliers_b] = estimateFundamentalMatrixRANSAC(pair1.Location,pair2.Location);
    inliers{i} = [inliers_a,inliers_b];
end
end