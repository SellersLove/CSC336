function bisection
% xr: rel solu from fzero
% fs: input functions
% [as,bs]: input interval
diary result.out
fs = {'x*x*x-2*x-5' 'exp(-x)-x' 'x*sin(x)-1' 'x*x*x - 3*x*x + 3*x - 1'};
as = {1 0 0 0};
bs = {4 2 2.4 3};
xr = {2.0947 0.5671 1.1142 1.0};
tol = 0.00001;
for k = 1:4
    i = 1;
    a = as{k};
    b = bs{k};
    fprintf('g_%g(x) = %s\n', k, fs{k});
    f = inline(fs{k},'x');
    x_fzero = xr{k};
    disp(sprintf('%3s %17s %17s %17s %17s %17s', 'k', 'a','f(a)','b','f(b)', 'ratio'));
    disp(sprintf('%3d %17.12f %17.12f %17.12f %17.12f', i, a, f(a), b, f(b)));
    err = abs(a  - x_fzero);
    if f(a) * f(b) > 0 
        disp(sprintf('Wrong Interval [%d, %d]', a, b))
    else
        while (b-a) > tol && i<50;
            i = i+1;
            m = a + (b-a)/2;
            if f(a)*f(m)  < 0 
                b = m;
                err_new = abs((a + (b-a)/2) - x_fzero);
                ratio = err_new/err;
                err = err_new;
                disp(sprintf('%3d %17.12f %17.12f %17.12f %17.12f %17.12f', i, a, f(a), b, f(b), ratio));
            end
            if f(a)*f(m)  > 0
                a = m;
                err_new = abs((a + (b-a)/2) - x_fzero);
                ratio = err_new/err;
                err = err_new;
                disp(sprintf('%3d %17.12f %17.12f %17.12f %17.12f %17.12f', i, a, f(a), b, f(b), ratio));
            end
        end
    end
    disp(sprintf('result = %3f',(a + (b-a)/2)));
    disp(sprintf('\n') );
end
diary off
