function [alpha, counter_func] = naive_armijo(x, n, p, func, rho, c, ~, counter_init, alpha0)
    alpha = alpha0;
    counter_func = counter_init;
    [f_k, ~, g_k, ~, counter_func] = func(x, n, counter_func, 0);
    while true
        [f, ~, ~, ~, counter_func] = func(x + alpha * p, n, counter_func, 0);
        if f <= f_k + c * alpha * p' * g_k
            break;
        end
        alpha = rho * alpha;
        if alpha < 1e-6
            break; 
        end;
    end
end