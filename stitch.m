function pano = stitch(img_a,h,best)
img_arr = {};
for i = 1:size(best,1)
    img_arr{i} = img_a{best(i,1)};
end
img_arr{i+1} = img_a{best(i,2)};
len = size(img_arr,2);
imageSize = zeros(len,2);
for i = 1:len
    temp = size(img_arr{i});
    imageSize(i,:) = temp(1:2);
end
len = size(h,2);
for i = 1:len
    [xlim(i,:), ylim(i,:)] = outputLimits(h(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end
avgXLim = mean(xlim, 2);

[~, idx] = sort(avgXLim);

centerIdx = floor((numel(h)+1)/2);

centerImageIdx = idx(centerIdx);
Tinv = invert(h(centerImageIdx));
I = img_arr{1};
for i = 1:numel(h)
    h(i).T = h(i).T * Tinv.T;
end
for i = 1:numel(h)
    [xlim(i,:), ylim(i,:)] = outputLimits(h(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end

maxImageSize = max(imageSize);

% Find the minimum and maximum output limits
xMin = min([1; xlim(:)]);
xMax = max([maxImageSize(2); xlim(:)]);

yMin = min([1; ylim(:)]);
yMax = max([maxImageSize(1); ylim(:)]);

% Width and height of panorama.
width  = round(xMax - xMin);
height = round(yMax - yMin);

% Initialize the "empty" panorama.
panorama = zeros([height width 3], 'like', I);
blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');
% blender1 = vision.AlphaBlender('Operation','blend');
% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);

I = img_arr{1};
warpedImage = imwarp(I, h(1), 'OutputView', panoramaView);
mask = imwarp(true(size(I,1),size(I,2)), h(1), 'OutputView', panoramaView);
panorama = step(blender,panorama,warpedImage,mask);
siz = size(panorama);
for i = 2:len
    I = img_arr{i};
    % Transform I into the panorama.
    warpedImage = imwarp(I, h(i), 'OutputView', panoramaView);
    % Generate a binary mask.
    mask = imwarp(true(size(I,1),size(I,2)), h(i), 'OutputView', panoramaView);
    % Overlay the warpedImage onto the panorama.
    %     panorama = step(blender,panorama,warpedImage,mask);
    %     panorama = max(panorama,step(blender, panorama, warpedImage));
%     mask1 = mask;
%     flag1 = 0;
%     flag2 = 0;
%     x2 = 0;
%     y2 = 0;
%     x3 = 0;
%     y3 = 0;
    
%     for j=1:siz(1)
%         for k=1:siz(2)
%             if mask(j,k) == 1
%                 if (panorama(j,k,1) == 0 && panorama(j,k,2) == 0 && panorama(j,k,3)==0)
%                     mask1(j,k) = 0;
%                 else
%                     mask1(j,k) = 1;
%                 end
%             end
%         end
%     end
% %     
%     for j=1:siz(1)
%         for k=1:siz(2)
%             if (mask1(j,k) == 1 && flag1 ==0 && flag2 ==0)
%                     x2 = j;
%                     y2 = k;
%                     flag1 = 1; 
%             end
%             if (mask1(j,k) == 0 && flag1 ==1 && flag2 ==0)
%                 x3 = j;
%                 y3 = k;
%                 flag2 = 1;
%                 break;
%             end
%         end
%         if (flag2 == 1)
%             break;
%         end
%     end
    w1 = 0.5;
    w2 = 0.5;
    for j=1:siz(1)
        for k=1:siz(2)
            if mask(j,k) == 1
                if (panorama(j,k,1) == 0 && panorama(j,k,2) == 0 && panorama(j,k,3)==0)
                    panorama(j,k,:) = warpedImage(j,k,:);
                else
%                     w1 = sqrt((j-x3)*(j-x3) + (k-y3)*(k-y3));
%                     w2 = sqrt((j-x2)*(j-x2) + (k-y2)*(k-y2));
                    panorama(j,k,:) = panorama(j,k,:)*(w2/(w2+w1)) + warpedImage(j,k,:)*(w1/(w1+w2));
                end
            end
        end
    end
end
pano = panorama;
end
