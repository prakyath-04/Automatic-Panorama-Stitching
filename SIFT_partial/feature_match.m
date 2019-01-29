function [ret,scores] = feature_match(f1,f2,d1,d2)
%% f1 and f2 are features, d1 and d2 are descriptors
[matches,scores] = vl_ubcmatch(d1,d2);
numMatch = size(matches,2);
if (numMatch ~=0)
    pairs = zeros(numMatch, 2, 2);
    pairs(:,:,1)=[f1(1,matches(1,:));f1(2,matches(1,:))]';
    pairs(:,:,2)=[f2(1,matches(2,:));f2(2,matches(2,:))]';
end
[scores,ind] = sort(scores);
ret = pairs(ind,:,:);
end
