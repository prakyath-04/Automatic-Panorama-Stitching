function [ans_inliers,ans_best] = find_order_update(inliers,pairs)
ans_inliers = {};
ans_best = [];
s1 = size(pairs,1);
ans_best = [ans_best;pairs(1,:)];
cnt = 1;
ans_inliers{cnt} = inliers{1};
X = pairs(1,2);
cnt = cnt + 1;
check = zeros(1000,1);
a1 = pairs(1,1);
a2 = pairs(1,2);
check(a1) = 1;
check(a2) = 1;
pairs(1,:) = zeros(1,2);
for i=1:s1-1
    k1 = find(pairs(:,1) == X);
    k2 = find(pairs(:,2) == X);
    mx = 0;
    mx_idx = 0;
    flag = 0;
    for i = 1:size(k1,1)
        if ((mx < size(inliers{k1(i,1)},1)) && (check(pairs(k1(i,1),2))==0))
            mx = size(inliers{k1(i,1)},1);
            mx_idx = k1(i,1);
        end
    end
    for i = 1:size(k2,1)
        if (mx < size(inliers{k2(i,1)},1) && (check(pairs(k2(i,1),1))==0))
            mx = size(inliers{k2(i,1)},1);
            mx_idx = k2(i,1);
            flag = 1;
        end
    end
    if (mx_idx == 0)
        break;
    end
    if (flag == 0)
    %%% From k1
        ans_best = [ans_best;pairs(mx_idx,:)];
        check(pairs(mx_idx,1),1) = 1;
        X = pairs(mx_idx,2);
        pairs(mx_idx,:) = zeros(1,2);
        ans_inliers{cnt} = inliers{mx_idx};
        cnt = cnt + 1;
    end
    if (flag == 1)
    %%% From k2  Changing inliers
        check(pairs(mx_idx,1),1) = 1;
        t = pairs(mx_idx,1);
        pairs(mx_idx,1) = pairs(mx_idx,2);
        pairs(mx_idx,2) = t;
        ans_best = [ans_best;pairs(mx_idx,:)];
        
        X = pairs(mx_idx,2);
        
        temp = inliers{mx_idx};
        t1 = temp(:,3:4);
        temp(:,3:4) = temp(:,1:2);
        temp(:,1:2) = t1;
        ans_inliers{cnt} = temp;
        cnt = cnt + 1;
        pairs(mx_idx,:) = zeros(1,2);
    end 
end
end