function q = get_quantile(I, res)
    I = mat2gray(abs(I));
    [c, bin] = imhist(I, 256);
    c = c/sum(c);
    M = zeros(length(c), length(c));
    for i=1:length(c)
        for j=1:length(c)
            M(i, j) = (i >= j);
        end
    end
    c = M * c;
    k = 1;
    q = zeros(1, res + 1);
    for p=0:1/res:1
        for i = 1:length(c)
            if c(i) < p
                q(k) = (i + 1)*(bin(2) - bin(1));
            end
        end
        k = k + 1;
    end
end