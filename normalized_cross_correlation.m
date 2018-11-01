function ncc = normalized_cross_correlation(I1, I2)
    mean_I1 = mean(mean(I1, 1), 2);
    mean_I2 = mean(mean(I2, 1), 2);
    I1 = I1 - mean_I1;
    I2 = I2 - mean_I2;
    I1 = I1 / sqrt(sum(sum(I1.^2, 1), 2));
    I2 = I2 / sqrt(sum(sum(I2.^2, 1), 2));
    ncc = sum(sum(I1 .* I2, 1), 2);
end
