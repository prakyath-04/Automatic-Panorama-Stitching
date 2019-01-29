function [match,pairs] = image_match(pts,ft)
n = size(ft,2);
match = {};pairs = zeros(n*n-1,2);
thresh = 300;
count = 1;
    for i = 1:n
        for j = i+1:n 
            if i==j
                continue;
            end
            idx_pairs = matchFeatures(ft{i},ft{j},'MaxRatio', .9, 'Unique',  true);
            matchedpts1 = pts{i}(idx_pairs(:,1));
            matchedpts2 = pts{j}(idx_pairs(:,2));
            if (matchedpts1.Count > thresh)    
                pairs(count,1) = i;
                pairs(count,2) = j;
                match{count,1} = [matchedpts1];
                match{count,2} = [matchedpts2];
                match{count,3} = [idx_pairs];
                count = count + 1;
            end
        end
    end
    pairs = pairs(1:count-1,:);
end