function [alpha, counter, counter_func] = naive_goldstein(x, n, p, rho, c, counter_init)
    alpha = 1;
    counter_func = 0;
    [f_k, ~, g_k, ~, counter_func] = watson(x, n, counter_func);
    while true
        [f, ~, ~, ~, counter_func] = watson(x + alpha * p, n, counter_func);
        if f <= f_k + c * alpha * p' * g_k
            break;
        end
        alpha = rho * alpha;
    end
    counter = counter_init + 1;
end