function [f,d] = getSIFTfeatures(img_arr)
thresh = 3;
if (size(img_arr,3) == 3)
    I = single(rgb2gray(img_arr));
else
    I = single(img_arr);
end
[f,d] = vl_sift(I,'EdgeThresh',thresh);
end