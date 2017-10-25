function [alpha, counter_func] = naive_strong_wolfe(x, n, p, rho, c1, c2, counter_func_init)
    alpha = 1;
    counter_func = counter_func_init;
    [f_k, ~, g_k, ~, counter_func] = watson(x, n, counter_func);
    while true
        [f, ~, g, ~, counter_func] = watson(x + alpha * p, n, counter_func);
        if f <= f_k + c1 * alpha * g_k' * p && abs(g' * p) <= c2 * abs(g_k' * p)
            break;
        end
        alpha = rho * alpha;
    end
end
