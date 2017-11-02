function [xmin, fval, counter_iter, counter_func, time] = bfgs(x0, n, func, iter_max, epsilon)
    time = cputime;
    x = x0;
    counter_func = 0;
    counter_iter = 0;
    
    [~, ~, g, G, counter_func] = func(x, n, counter_func, 1);

    H = G;
    v = eig(G);
    if min(v) < 0
        H = H + (-min(v) + 1e-5) * eye(n);
    end
    
    while g' * g > epsilon
        counter_iter = counter_iter + 1;
        
        if counter_iter > iter_max
            disp('iteration terminated!');
            break;
        end
        d = - H * g;
%        [alpha, counter_func] = acc(x, n, d, counter_func);
%        [alpha, counter_func] = naive_armijo(x, n, d, func, 0.99, 1e-4, 0, counter_func, 1);
        [alpha, counter_func] = naive_goldstein(x, n, d, func, 0.99, 0.25, 0, counter_func, 1);
%        [alpha, counter_func] = naive_wolfe(x, n, d, func, 0.99, 1e-4, 0.999999999, counter_func, 1);
%        [alpha, counter_func] = naive_strong_wolfe(x, n, d, func, 0.99, 1e-4, 0.9, counter_func, 1);
%        alpha = 1e-9;
        x = x + alpha * d;
        [~, ~, g1, ~, counter_func] = func(x, n, counter_func, 0);
        y = g1 - g;
        s = alpha * d;
        g = g1;
        if y' * y < 1e-30
            disp('grad diff is to small');
            break;
        end
%        disp(y);
        H = H + (1 + (y' * H * y) / (y' * s)) * ((s * s') / (y' * s)) - (s * y' * H + H * y * s') / (y' * s);
    end
    xmin = x;
    [fval, ~, ~, ~, counter_func] = func(xmin, n, counter_func, 0);
    time = cputime - time;    
end