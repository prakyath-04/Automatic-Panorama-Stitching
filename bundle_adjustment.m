function [hmatrixauto1] = bundle_adjustment(inliers,v)
    %%% Estimating H matrix
    no_of_inliers = size(inliers,1);
    hvector(1:3) = v(1,:);
    hvector(4:6) = v(2,:);
    hvector(7:9) = v(3,:);
    ydata = zeros(1,no_of_inliers);
    options = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','MaxIterations',1000);
    lb = [];
    ub = [];
    hoptim = lsqcurvefit(@myfun,hvector,inliers,ydata,lb,ub,options);
    hmatrixauto1 = [hoptim(1), hoptim(2), hoptim(3); hoptim(4), hoptim(5), hoptim(6); hoptim(7), hoptim(8), hoptim(9)];
    hmatrixauto1 = hmatrixauto1./hmatrixauto1(3,3);
    hmatrixauto1 = hmatrixauto1';
end

function ydata = myfun(x, xdata)
    ydata = zeros(1,length(xdata));
    hmatrixtemp = [x(1), x(2), x(3); x(4), x(5), x(6); x(7), x(8), x(9)];
    for i = 1:length(xdata)   
        temp1 = hmatrixtemp*[xdata(i,1,1); xdata(i,1,2); 1];
        temp1 = temp1/temp1(3);
        temp2 = hmatrixtemp\[xdata(i,2,1); xdata(i,2,2); 1];
        temp2 = temp2/temp2(3);
        error1 = sum(abs([xdata(i,2,1); xdata(i,2,2); 1] - temp1));
        error2 = sum(abs([xdata(i,1,1); xdata(i,1,2); 1] - temp2));
        ydata(i) = error1 + error2;
    end
end