function [inliers_a,inliers_b] = estimateFundamentalMatrixRANSAC(corresponding_pts1, corresponding_pts2)
s1 = size(corresponding_pts1,1);

[~,inliers_f] = estimateFundamentalMatrix(corresponding_pts1,corresponding_pts2,'NumTrials',1000);

count = 1;
inliers_a = zeros(s1,2);
inliers_b = inliers_a;
for i=1:s1
    if (inliers_f(i) == 1)
        inliers_a(count,:) = corresponding_pts1(i,1:2);
        inliers_b(count,:) = corresponding_pts2(i,1:2);
        count=count+1;
    end
end
inliers_a = inliers_a(1:count-1,:);
inliers_b = inliers_b(1:count-1,:);

end