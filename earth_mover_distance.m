function d = earth_mover_distance(I1, I2)
    % I1 is the target image
    % I2 is the moving image
    res = 1000;
    q1 = get_quantile(mat2gray(I1), res);
    q2 = get_quantile(mat2gray(I2), res);
    q3 = get_quantile(mat2gray(-1 * I2), res); % Calculating quantile of the reverse contrast
    % To account for the reverse contrast image we calculate two quantiles
    % and take the one that gives the maximum match
    d1 = -sqrt(sum((q1 - q2).^2)) + 1;
    d2 = -sqrt(sum((q1 - q3).^2)) + 1;
    d = max(d1, d2);
end