function [h] = bun(best,inliers,N,k)
len = N;
hm = {};
for i=1:k
    hm{i} = projective2d(eye(3));
end
len = size(best,1);
for i=1:len 
    [temp,inliers1,inliers2] = estimateGeometricTransform(inliers{i}(:,3:4)...
        ,inliers{i}(:,1:2),'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);
    H_test = temp.T;
    inliers_out = zeros(size(inliers1,1),2,2);
    inliers_out(:,1,1:2) = inliers1(:,1:2);
    inliers_out(:,2,1:2) = inliers2(:,1:2);
    H_final = bundle_adjustment(inliers_out,H_test');
    hm{best(i,2)}.T = H_final;
end
% for i =2:len
%     hm{i}.T = hm{i}.T * hm{i-1}.T;
% end

len = size(best,1);
i=1;
% disp(hm);
while i <= len
    hm{best(i,2)}.T = hm{best(i,2)}.T* hm{best(i,1)}.T;
    i=i+1;
end
len = N;
% disp(h);
h(len)=projective2d(eye(3));
% disp(h);
len = size(best,1);
for i=1:len
%     disp(i);
    h(i).T = hm{best(i,1)}.T;
end
h(i+1).T = hm{best(i,2)}.T;
end