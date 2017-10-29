function [alpha, counter_func] = naive_wolfe(x, n, p, func, rho, c1, c2, counter_func_init, alpha0)
    alpha = alpha0;
    counter_func = counter_func_init;
    [f_k, ~, g_k, ~, counter_func] = func(x, n, counter_func);
    while true
        [f, ~, g, ~, counter_func] = func(x + alpha * p, n, counter_func);
        if f <= f_k + c1 * alpha * g_k' * p && g' * p >= c2 * g_k' * p
            break;
        end
        alpha = rho * alpha;
        if alpha < 1e-6
            break; 
        end;
    end
end
