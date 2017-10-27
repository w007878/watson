function [alpha, counter_func] = naive_armijo(x, n, p, func, rho, c, ~, counter_init)
    alpha = 1;
    counter_func = counter_init;
    [f_k, ~, g_k, ~, counter_func] = func(x, n, counter_func);
    while true
        [f, ~, ~, ~, counter_func] = func(x + alpha * p, n, counter_func);
        if f <= f_k + c * alpha * p' * g_k
            break;
        end
        alpha = rho * alpha;
    end
end