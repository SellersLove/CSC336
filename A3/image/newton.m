function newton
% xs: intial guess
% xr: rel solu from fzero 
% iteration: ieration times
% fs: input functions
% gs: g(x) = f'(x)
diary result.out
fs = {'x*x*x-2*x-5' 'exp(-x)-x' 'x*sin(x)-1' 'x*x*x - 3*x*x + 3*x - 1'};
gs = {'3*x*x-2' '-exp(-x)-1' 'sin(x) + x*cos(x)' '3*x*x -6*x +3'};
xs = {1 0 0.1 0};
xr = {2.0947 0.5671 1.1142 1.0};
tol = eps;


for k = 1:4
    i = 1;
    f = inline(fs{k},'x');
    g = inline(gs{k},'x');
    x = xs{k};
    fprintf('g_%g(x) = %s\n', k, fs{k});
    fprintf('%3s %17s %17s %17s %17s %17s\n', 'k', 'xk','f(xk)','g(xk)', 'hk', 'ratio');
    fprintf('%3d %17f %17f %17f %17f\n', i, x, f(x), g(x), -f(x)/g(x));
    x_fzero = xr{k};
    err = abs(x - x_fzero);
    while abs(f(x)) > tol && i<20
        i = i+1;
        x = x - f(x)/g(x);
        err_new = abs(x - x_fzero);
        ratio = err_new/(err);
        err = err_new;
        fprintf('%3d %17f %17f %17f %17f %17f\n', i, x, f(x), g(x), -f(x)/g(x),err);
    end
    fprintf('\n');
end
diary off

