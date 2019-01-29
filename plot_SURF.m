function plot_SURF(img_arr,m,pairs,inliers)
for i = 1:2
    figure;
    subplot(2,2,1);
    imshow(img_arr{pairs(i,1)}),title(['image mathces ' num2str(pairs(i,1)) ]);
    hold on;
    scatter(m{i,1}.Location(:,1),m{i,1}.Location(:,2),'r');
    hold off;
    subplot(2,2,2);
    imshow(img_arr{pairs(i,2)}),title(['image matches' num2str(pairs(i,2)) ]);
    hold on;
    scatter(m{i,2}.Location(:,1),m{i,2}.Location(:,2),'y');
    hold off;
    subplot(2,2,3);
    imshow(img_arr{pairs(i,1)}),title(['image mathces after RANSAC ' num2str(pairs(i,1)) ]);
    hold on;
    scatter(inliers{i}(:,1),inliers{i}(:,2),'r');
    hold off;
    subplot(2,2,4);
    imshow(img_arr{pairs(i,2)}),title(['image matches after RANSAC ' num2str(pairs(i,2)) ]);
    hold on;
    scatter(inliers{i}(:,3),inliers{i}(:,4),'y');
    hold off;
    
end
end