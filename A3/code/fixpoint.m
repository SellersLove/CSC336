 function fixpoint % fixed-point iteration
    diary 1b.out
    fs = {'(x*x+2)/3' 'sqrt(3*x-2)' '3-2/x' '(x*x-2)/(2*x-3)'};
    tol = 0.01; 
    x_rel = 2; 
    for i = 1 : 4
        fprintf('g_%g(x) = %s\n', i, fs{i}); 
        g = inline(fs{i},'x');
        disp('  k               x              err                ratio');
        k = 0; 
        x = 3.0;
        err = abs(x-x_rel);
        fprintf('%3d %17e %17e\n', k, x, err);
        while err > tol && k < 12;
            k = k+1;
            x = g(x);
            err_new = abs(x-x_rel);
            ratio = err_new/err;
            err = err_new;
            fprintf('%3d %17e %17e %17e\n', k, x, err, ratio);
        end; 
        disp(' ');
    end
    diary off