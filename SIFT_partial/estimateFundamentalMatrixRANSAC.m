function [inliers_a,inliers_b] = estimateFundamentalMatrixRANSAC(corresponding_pts1, corresponding_pts2)
s1 = size(corresponding_pts1,1);

[~,inliers_f] = estimateFundamentalMatrix(corresponding_pts1,corresponding_pts2,'NumTrials',500);

n = 8;
inliers = 0;
%%% Threshold error
error_thresh = 0.0005;
norm_F = zeros(3,3);
%%% Homogeneous Representaion
corresponding_pts1(:,3) = ones(s1,1);
corresponding_pts2(:,3) = ones(s1,1);
flag = zeros(s1,1);
%%% RANSAC Loop
for i = 1:500
    %%% Random 8 Points
    ind = randi(s1, [n,1]);
    %%% normalizing those 8 points
    [norm2Dpts1 , T1] = normalize2DPoints(corresponding_pts1(ind,:));
    [norm2Dpts2 , T2] = normalize2DPoints(corresponding_pts2(ind,:));
    %%% Estimating F from the selected 8 points
    F_Estimate = Normalized_Estimate_F_Matrix(norm2Dpts1,norm2Dpts2);
    F_Estimate = T2'* F_Estimate * T1;
    %%% Checking error from computed F
    err = sum((corresponding_pts2 .* (F_Estimate * corresponding_pts1')'),2);
    current_inliers = size( find(abs(err) <= error_thresh) , 1);
    if (current_inliers > inliers)
        norm_F = F_Estimate;
        inliers = current_inliers;
    end
end

% disp(inliers);
err = sum((corresponding_pts2 .* (norm_F * corresponding_pts1')'),2);
count = 1;
inliers_a = zeros(s1,2);
inliers_b = inliers_a;
inl_thresh = 0.0001;
for i=1:s1
%         if (err(i) <=inl_thresh)
    if (inliers_f(i) == 1)
        inliers_a(count,:) = corresponding_pts1(i,1:2);
        inliers_b(count,:) = corresponding_pts2(i,1:2);
        count=count+1;
    end
end
inliers_a = inliers_a(1:count-1,:);
inliers_b = inliers_b(1:count-1,:);

end