m = 128;
k = 4;
r = 0.25/k;
sigma = 2;

target = imgaussfilt(draw_fan(m, k, r), sigma);
methods = ["ncc", "emd", "mi"];
count = 1;
paramSet = [1, 0; 1000, 0; 1000, 1000; -500, 1000];
[p, q] = size(paramSet);
for i=1:p
    A = paramSet(i, 1);
    B = paramSet(i, 2);
    measureMat = zeros(length(method), length(method));
    i = 1;
    for method = methods
        fprintf('Image match measure : %s\n', method);
        [angle, funcVal] = findBestFit(target, A, B, 0, 0.25/(2*k), pi, method);
        subplot(p, length(methods), count);
        plot(angle/pi, funcVal);
        xlabel('angle (1 unit = pi)');
        ylabel('image match');
        if strcmp(method, 'ncc')
            title(strcat('Normalized Cross Correlation ( A = ', num2str(A), ', B = ', num2str(B), ' )'));
        elseif strcmp(method, 'emd')
            title(strcat('Quantile Function ( A = ', num2str(A), ', B = ', num2str(B), ' )'));
        elseif strcmp(method, 'mi')
            title(strcat('Mutual Information ( A = ', num2str(A), ', B = ', num2str(B), ' )'));
        end
        
        hold on;

        % Measure 1
        [result, ind] = max(funcVal);
        measure1 = abs(r - angle(ind))/r;

        % Measure 2
        pks = sort(findpeaks(funcVal), 'descend');
        measure2 = abs(pks(1) - pks(2)) * 100/pks(1);

        % Measure 3
        measure3 = Inf;
        if ind > 1 && ind < length(funcVal)
            measure3 = (funcVal(ind - 1) - 2 * funcVal(ind) + funcVal(ind + 1)) / (2 * (angle(2) - angle(1) ^ 2));
        end

        fprintf('Measure 1 : %f\nMeasure 2 : %f\nMeasure 3 : %f\n', measure1, measure2, measure3);
        measureMat(i, 1) = measure1;
        measureMat(i, 2) = measure2;
        measureMat(i, 3) = measure3;
        count = count + 1;
        i = i + 1;
    end
    save(strcat("measureMat_", num2str(A), "_", num2str(B), ".mat"), 'measureMat');
end

