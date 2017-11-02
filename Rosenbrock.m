function [f, r, grad, H, counter] = Rosenbrock(x, ~, counter_init, keepH)
    counter = counter_init + 1;
    r = []; grad = []; H = [];
    r(1) = 10 * (x(2) - x(1)^2);
    r(2) = 1 - x(1);
    f = r(1)^2 + r(2)^2;
    grad(1, 1) = 400 * x(1)^3 - 400 * x(1) * x(2) + 2 * x(1) - 2;
    grad(2, 1) = 200 * x(2) - 200 * x(1)^2;
    
    if keepH == 0
        return
    end
    H(1, 1) = 1200 * x(1) ^ 2 - 400 * x(2) + 2;
    H(1, 2) = -400 * x(1);
    H(2, 1) = -400 * x(1);
    H(2, 2) = 200;

end