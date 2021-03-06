function [f, r, grad, H, counter] = freudenstein_roth(x, ~, counter_init, keepH)
    counter = counter_init + 1;    r = []; grad = []; H = [];
    r(1) = -13 + x(1) + ((5 - x(2)) * x(2) - 2) * x(2);
    r(2) = -29 + x(1) + ((x(2) + 1) * x(2) - 14) * x(2);
    f = r(1)^2 + r(2)^2;
    grad(1, 1) = 2 * r(1) + 2 * r(2);
    grad(2, 1) = 2 * r(1) * ((5 - x(2)) * x(2) - 2 + x(2) * (5 - 2 * x(2))) + 2 * r(2) * ((x(2) + 1) * x(2) - 14 + x(2) * (2 * x(2) + 1));
    if keepH == 0
        return;
    end
    H(1, 1) = 4;
    H(1, 2) = 24*x(2) - 32;
    H(2, 1) = 24*x(2) - 32;
    H(2, 2) = 24 + 24*x(1) - 480*x(2) + 24*x(2)^2 - 160*x(2)^3 + 60*x(2)^4;
end