function [xmin, fval, counter_iter, counter_func, time] = damped_newton(x0, n, func, iter_max, epsilon)
    time = cputime;
    x = x0;
    counter_func = 0;
    counter_iter = 0;
    
    [~, ~, g, G, counter_func] = func(x, n, counter_func, 1);

    while g' * g > epsilon
        counter_iter = counter_iter + 1;
        if counter_iter > iter_max
            disp('iteration terminated!');
            break;
        end
    
        if det(G) == 0
            disp('Hesse Matrix Singular');
            break;
        end
        
        [~, p] = chol(G);
        if p ~= 0
            disp('Hesse Matrix Not positive definite');
            break;
        end

%        disp(G);
%        disp(g);
        d = -inv(G) * g;
%        [alpha, counter_func] = acc(x, n, d, counter_func);
%        [alpha, counter_func] = naive_armijo(x, n, d, func, 0.99, 1e-4, 0, counter_func, 1);
        [alpha, counter_func] = naive_goldstein(x, n, d, func, 0.99, 0.25, 0, counter_func, 1);
%        [alpha, counter_func] = naive_wolfe(x, n, d, func, 0.99, 1e-4, 0.9, counter_func, 1);
%        [alpha, counter_func] = naive_strong_wolfe(x, n, d, func, 0.99, 1e-4, 0.9, counter_func, 1);
        
%        alpha = 1e-3;  
        x = x + alpha * d;
        [~, ~, g, G, counter_func] = func(x, n, counter_func, 1);
    end
    xmin = x;
    [fval, ~, ~, ~, counter_func] = func(xmin, n, counter_func, 0);
    time = cputime - time;
end 