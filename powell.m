function [f, r, grad, H, counter] = powell(x, ~, counter_init, keepH)
    counter = counter_init + 1;
    r = []; grad = []; H = [];
    r(1) = 10^4 * x(1) * x(2) - 1;
    r(2) = exp(-x(1)) + exp(-x(2)) - 1.0001;
    f = r(1)^2 + r(2)^2;
    grad(1, 1) = 2 * r(1) * (10^4 * x(2)) + 2 * r(2) * (-exp(-x(1)));
    grad(2, 1) = 2 * r(1) * (10^4 * x(1)) + 2 * r(2) * (-exp(-x(2)));
    
    if keepH == 0
        return;
    end
    H(1, 1) = 2 * (10^4 * x(2))^2 + 2 * (-exp(-x(1)))^2 + 2 * r(2) * exp(-x(1));
    H(1, 2) = 2 * (10^4 * x(1)) * (10^4 * x(2)) + 2 * 10^4 * r(1) + 2 * exp(-x(1) -x(2));
    H(2, 1) = 2 * (10^4 * x(1)) * (10^4 * x(2)) + 2 * 10^4 * r(1) + 2 * exp(-x(1) -x(2));    
    H(2, 2) = 2 * (10^4 * x(1))^2 + 2 * (-exp(-x(2)))^2 + 2 * r(2) * exp(-x(2));
end