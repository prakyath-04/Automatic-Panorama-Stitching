function [ret,match] = image_match(ft,ds)
    %%% Threshold score = 2500 and percentage of inliers = 25%
    thresh = 10000;
    percent = 0.20;
    num_of_inliers = 70;
    n = size(ft,2);
    flag = zeros(n);
    count = 1;
    match = {};
    out = zeros(n*n-1,2);
    for i = 1:n
        for j = i+1:n 
            if i==j
                continue;
            end
            [matches,scores] = feature_match(ft{i},ft{j},ds{i},ds{j});
            m = size(scores,2);
            if ((scores(floor(0.25*m)) <= thresh) && (m>=num_of_inliers))
                flag(i,j) = 1;
                out(count,1) = i;
                out(count,2) = j;
                match{count} = matches;
                count = count+1;
            end
        end
    end
    ret = out(1:count-1,:);
end
