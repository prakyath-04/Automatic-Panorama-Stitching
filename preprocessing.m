function [out] = preprocessing(img_arr)
n = size(img_arr,2);
out ={};
max_size = 800;
for i = 1:n
    I = img_arr{i};
    sz = size(I);
    [~,ind] = max(sz);
    scale = max_size/sz(ind);
    out{i} = imresize(I,scale);
end
end