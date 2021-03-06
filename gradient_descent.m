function [xmin, fval, counter_iter, counter_func, time] = gradient_descent(x0, n, func, iter_max, epsilon)
    time = cputime;
    x = x0;
    counter_func = 0;
    counter_iter = 0;
    
    [~, ~, g, ~, counter_func] = func(x, n, counter_func);

    while g' * g > epsilon
        counter_iter = counter_iter + 1;
        if counter_iter > iter_max
            disp('iteration terminated!');
            break;
        end
        d = -g;
%        [alpha, counter_func] = acc(x, n, d, counter_func);
%        [alpha, counter_func] = naive_armijo(x, n, d, func, 0.99, 1e-4, 0, counter_func, 1);
%        [alpha, counter_func] = naive_goldstein(x, n, d, func, 0.99, 0.25, 0, counter_func, 1);
%        [alpha, counter_func] = naive_wolfe(x, n, d, func, 0.99, 1e-4, 0.9, counter_func, 1);
        [alpha, counter_func] = naive_strong_wolfe(x, n, d, func, 0.999, 1e-6, 0.99, counter_func, 100);
%        alpha = 1e-5;
        x = x + alpha * d;
        [~, ~, g, ~, counter_func] = func(x, n, counter_func);
    end
    xmin = x;
    [fval, ~, ~, ~, counter_func] = func(xmin, n, counter_func);
    time = cputime - time;    
end