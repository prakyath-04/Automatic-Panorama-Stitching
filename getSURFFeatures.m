function [points,features] = getSURFFeatures(I)
if (size(I,3) ==3)
    I = rgb2gray(I);
end
points   = detectSURFFeatures(I, 'MetricThreshold',1.5);
features = extractFeatures(I, points);
end