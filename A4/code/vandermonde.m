function vandermonde
% bases: diff bases for vandermonde function
% xr: rel solu from fzero 
% iteration: ieration times
% fs: input functions
% gs: g(x) = f'(x)
diary question1.out
bases = {'t' 't - 1900' 't - 1940' '( t - 1940 )/40'};

for i = 1:4
    v = 1900:10:1980; 
    f = inline(bases{i},'t');
    for j = 1:9
        v(j) = f(v(j));
    end
    A = fliplr(vander(v));
    condi = cond(A);
    format short;
    fprintf('condition number is %5.2e\n', condi);
end
diary off