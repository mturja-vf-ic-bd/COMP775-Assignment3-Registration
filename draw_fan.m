function fan = draw_fan(m, k, r)
    % m is the width and length of the image
    % k is proportional to fan count
    % r is a rotational constant
    fan = zeros(m, m);
    pivot_point = [(m+1)/2; (m+1)/2];
    fan = transpose(fan); % I like to think about x axis as horizontal. But in image x is vertical. So transposing it. I will transpose it back.
    for x = 1:m
        for y = 1:m
            t_vec = [x; y] - pivot_point;
            theta = acos([cos(r), sin(r)] * t_vec/sqrt(sum(t_vec.^2)));
            fan(x, y) = 1/(1 + abs(theta).^2) * cos(2 * pi * k * theta);
        end
    end
    fan = ceil(256 * mat2gray(transpose(fan))); % transposing it back as promised.
end

