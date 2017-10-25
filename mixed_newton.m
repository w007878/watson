function [xmin, fval, counter_iter, counter_func, time] = mixed_newton(x0, n, iter_max, epsilon, epsilon1, epsilon2)
    time = cputime;
    x = x0;
    counter_func = 0;
    counter_iter = 0;
    
    [~, ~, g, G, counter_func] = watson(x, n, counter_func);
    
    while g' * g > epsilon
        counter_iter = counter_iter + 1;
        if counter_iter > iter_max
            xmin = nan; fval = inf;
            return;
        end
        if det(G) ~= 0
            d = -inv(G) * g;
        else
            d = -g;
        end
        
        if g' * d > epsilon1 * sqrt((g' * g) * (d' * d))
            d = -d;
        else if abs(g' * d) <= epsilon2 * sqrt((g' * g) * (d' * d))
                d = -g;
            end
        end
        
%        [alpha, counter_func] = acc(x, n, d, counter_func);
%        [alpha, counter_func] = naive_armijo(x, n, d, 0.01, 0.1, counter_func);
%        [alpha, counter_func] = naive_goldstein(x, n, d, 0.01, 0.1, counter_func);
%        [alpha, counter_func] = naive_wolfe(x, n, d, 0.01, 0.01, 0.1,counter_func);
        [alpha, counter_func] = naive_strong_wolfe(x, n, d, 0.01, 0.01, 0.1, counter_func);
        
        x = x + alpha * d;
        [~, ~, g, G, counter_func] = watson(x, n, counter_func);
    end
    xmin = x;
    [fval, ~, ~, ~, counter_func] = watson(xmin, n, counter_func);
    time = cputime - time;
end