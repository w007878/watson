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
    
    C = T1 * x;
    prx = (0:28)' .* T2 - 2 * T1 .* C;
    prz = [prx; [1, zeros(1, n-1)]; [-2 * x(1), 1, zeros(1, n-2)]];
    grad = 2 * prz' * r;
    
    H = zeros(n, n);
    for a = 1:n
        for b = 1:n           
            H(a, b) = 2 * prz(:, b)' * prz(:, a) - 4 * (power(t, a + b - 2) * r(1:29));
            if (a == 1) && (b == 1) 
                H(a, b) = H(a, b) - 4 * r(31);
            end
        end
    end
    counter = counter_init + 1;
end