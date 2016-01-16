function bisection
% xr: rel solu from fzero
% fs: input functions
% [as,bs]: input interval
diary result.out
fs = {'x*x*x-2*x-5' 'exp(-x)-x' 'x*sin(x)-1' 'x*x*x - 3*x*x + 3*x - 1'};
as = {1 -0.4 1 0};
bs = {6  0.8 2 3};

tol = eps;
for k = 1:4
    i = 1;
    a = as{k};
    b = bs{k};
    fprintf('g_%g(x) = %s\n', k, fs{k});
    f = inline(fs{k},'x');
    disp(sprintf('%3s %17s %17s %17s %17s', 'k', 'a','f(a)','b','f(b)'));
    disp(sprintf('%3d %17f %17.12f %17.12f %17.12f', i, a, f(a), b, f(b)));
    if f(a) * f(b) > 0 
        disp(sprintf('Wrong Interval [%d, %d]', a, b))
    else
        while (b-a) > tol && i<50;
            i = i+1;
            m = a + (b-a)/2;
            if f(a)*f(m)  < 0 
                b = m;
                disp(sprintf('%3d %17.12f %17.12f %17.12f %17.12f', i, a, f(a), b, f(b)));
            end
            if f(a)*f(m)  > 0
                a = m;
                disp(sprintf('%3d %17.12f %17.12f %17.12f %17.12f', i, a, f(a), b, f(b)));
            end
        end
    end
    disp(sprintf('result = %3f',(a + (b-a)/2)));
    disp(sprintf('\n') );
end
diary off
