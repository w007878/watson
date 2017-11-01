function [alpha, counter, counter_func] = naive_goldstein(x, n, p, func, rho, c, ~, counter_init, alpha0)
    alpha = alpha0;
    counter_func = 0;
    [f_k, ~, g_k, ~, counter_func] = func(x, n, counter_func);
    while true
        [f, ~, ~, ~, counter_func] = func(x + alpha * p, n, counter_func);
        if f_k + (1 - c) * alpha * g_k' *p <= f && f <= f_k + c * alpha * p' * g_k
            break;
        end
        alpha = rho * alpha;
        if alpha < 1e-6 
            break; 
        end;        
    end
    counter = counter_init + 1;
end