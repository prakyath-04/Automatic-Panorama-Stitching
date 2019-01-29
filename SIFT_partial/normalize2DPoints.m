function [normPts2D , T] =  normalize2DPoints(pts2D)
%%% Normalizing the mean
m1 = mean(pts2D);
s1 = size(pts2D,1);
d = 0;
%%% Finding the distance
for i = 1:s1
    x = pts2D(i,1) - m1(1,1);
    y = pts2D(i,2) - m1(1,2);
    d = d + sqrt((x*x) + (y*y));
end
d = d/s1;
scale = sqrt(2)/d;
%%% Finding the transform matrix
T = [scale 0 -scale*m1(1,1);0 scale -scale*m1(1,2);0 0 1];
for i = 1:s1
    normPts2D(i,:) = transpose(T * transpose(pts2D(i,:)));
end
end
