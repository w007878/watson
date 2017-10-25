function [alpha, counter] = acc(x, n, p, counter_init)
    syms a;
    counter = counter_init;
    [~, r, ~, ~, ~] = watson(x, n, counter);
    tmp = symfun(0, a);
    for i = 1:29
        Ai = 0; Bi = 0; Ci = 0;
        for j = 1:n
            Ai = Ai + x(j) * power(i / 29, j - 1);
            Bi = Bi + p(j) * power(i / 29, j - 1);
            Ci = Ci + (j - 1) * p(j) * power(i / 29, j - 2);
        end
        tmp = tmp + power((r(i) + 2 * Ai * Bi + Ci) * a - Bi ^ 2 * a ^ 2, 2);
    end
    tmp = tmp + (x(1) + a * p(1)) ^ 2 + (x(2) + a * p(2) - (x(1) + a * p(1)) ^ 2 - 1);
    [w, ~] = fminbnd(tmp, 0, 1);
    alpha = double(w);
end