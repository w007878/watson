function [xmin, fval, counter_iter, counter_func, time] = lm(x0, n, func, iter_max, epsilon)
    time = cputime;
    x = x0;
    counter_func = 0;
    counter_iter = 0;
    
    [~, ~, g, G, counter_func] = func(x, n, counter_func);

    while g' * g > epsilon
        counter_iter = counter_iter + 1;
        if counter_iter > iter_max
            disp('iteration terminated!');
            break;
        end
    
        v = eig(G);
        if(min(v) <= 0)
            G = G + (-min(v) - 1e-5) * eye(n);
        end
%        disp(G);
%        disp(g);
        while rcond(G) < 1e-15
            G = G + eye(n);
        end
        d = -inv(G) * g;
%        [alpha, counter_func] = acc(x, n, d, counter_func);
%        [alpha, counter_func] = naive_armijo(x, n, d, func, 0.99, 1e-4, 0, counter_func, 1);
%        [alpha, counter_func] = naive_goldstein(x, n, d, func, 0.99, 0.25, 0, counter_func, 1);
%        [alpha, counter_func] = naive_wolfe(x, n, d, func, 0.99, 1e-4, 0.9, counter_func, 1);
        [alpha, counter_func] = naive_strong_wolfe(x, n, d, func, 0.99999, 1e-4, 0.9, counter_func, 1);

        x = x + alpha * d;
        [~, ~, g, G, counter_func] = func(x, n, counter_func);
    end
    xmin = x;
    [fval, ~, ~, ~, counter_func] = func(xmin, n, counter_func);
    time = cputime - time;    
end