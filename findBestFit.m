function [ angle, funcVal ] = findBestFit(target, A, B, s_angle, interval, s_end, method)
    angle = zeros(1, floor((s_end - s_angle)/interval) + 1);
    funcVal = zeros(1, floor((s_end - s_angle)/interval) + 1);
    count = 1;
    for theta = s_angle:interval:s_end
        source = getMovingImage(A, B, theta);
        if strcmp(method, 'ncc')
            im = normalized_cross_correlation(source, target);
        elseif strcmp(method, 'emd')
            im = earth_mover_distance(source, target);
        elseif strcmp(method, 'mi')
            im = cal_mi(source, target);
        end
        
        angle(1, count) = theta;
        funcVal(1, count) = im;
        count = count + 1;
    end
end