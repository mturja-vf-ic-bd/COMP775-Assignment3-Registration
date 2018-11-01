function target = getMovingImage(A, B, r)
    m = 128;
    k = 4;
    sigma = 2;
    target = A .* imgaussfilt(draw_fan(m, k, r), sigma) + B;
end