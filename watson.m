function [f, r, grad, H, counter] = watson(x, n, counter_init)
    m = 29;
    t = (1:29) ./ 29; 
    T0 = repmat(t', 1, n - 1);
    T0 = T0 .^ (0:n-2);
    T1 = [T0, power(t, n - 1)'];
    T2 = [zeros(m, 1), T0];
    
    r = T2 * (x .* (0:n-1)') - power(T1 * x, 2) - 1;
    r = [r; x(1); x(2) - x(1) ^ 2 - 1];

    f = r' * r;
    
    tmp1 = 4 * T1' * (r(1:29) .* (T1 * x));
    tmp2 = 2 * (0:n-1)' .* (T2' * r(1:29));

    grad = tmp2 - tmp1;
    grad(1) = grad(1) + 2 * r(30) - 4 * x(1) * r(31);
    grad(2) = grad(2) + 2 * r(31);
   
    H = zeros(n, n);
    for a = 1:n
        for b = 1:n           
%            H(a, b) = 2 * prz(:, b)' * prz(:, a) - 4 * (power(t, a + b - 2) * r(1:29));
%            if (a == 1) && (b == 1) 
%                H(a, b) = H(a, b) - 4 * r(31);
%            end
            H(a, b) = 2 * r(1:29)' * power(t', a + b - 2);
            for i = 1:m
                w1 = (a - 1) * t(i)^(a - 2);
                w2 = (b - 1) * t(i)^(b - 2);
                for j = 1:n
                    w1 = w1 - 2 * x(j) * t(i)^(j + a - 2);
                    w2 = w2 - 2 * x(j) * t(i)^(j + b - 2);
                end
                H(a, b) = H(a, b) + w1 * w2;
                
            end
        end
    end
    counter = counter_init + 1;
end