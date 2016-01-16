function secant
% x1,x2: intinal guess
% xr: rel solu from fzero
% iteration: ieration times
% fs: input functions
diary result.out
fs = {'x*x*x-2*x-5' 'exp(-x)-x' 'x*sin(x)-1' 'x*x*x - 3*x*x + 3*x - 1'};
x1s = {1 -20 1 0};
x2s = {3 20 2 3};
xr = {2.0947 0.5671 1.1142 1.0};
tol = 0.001;

for k = 1:4
    i = 2;
    f = inline(fs{k},'x');
    x1 = x1s{k};
    x2 = x2s{k};
    fprintf('g_%g(x) = %s\n', k, fs{k});
    fprintf('%3s %17s %17s %17s %17s\n', 'k', 'xk','f(xk)','hk', 'err');
    fprintf('%3d %17f %17f %17f \n', 1, x1, f(x1));
    fprintf('\n');
    fprintf('%3d %17f %17f %17f\n',2, x2, f(x2), -f(x2)*(x2-x1)/(f(x2)-f(x1)));
    x_fzero = xr{k};
    err = abs(x2 - x_fzero);
    while abs(f(x2)) > tol && i<20
       i = i+1; 
       s = x2 - f(x2)*(x2-x1)/(f(x2)-f(x1)); 
       x1 = x2;
       x2 = s;
       err_new = abs(x2 - x_fzero);
       ratio = err_new/err;
       err = err_new;
       fprintf('%3d %17f %17f %17f %17e\n', i, x2, f(x2), -f(x2)*(x2-x1)/(f(x2)-f(x1)),err);
    end
    fprintf('\n');
end
diary off



