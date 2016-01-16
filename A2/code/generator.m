
function [] = generator()

    diary result.out
    % format output
    disp(sprintf('iteration     reltive error     relative residual     condintion       determinant\n'))
    iteration = 1;
    [A, b , reltiveError,relativeResidual,condintion,determinant] = gauss(iteration);
    % format output
    formatSpec = '%d              %e         %e     %e     %e \n';
    disp(sprintf(formatSpec,iteration,reltiveError,relativeResidual,condintion,determinant))
    iteration = iteration + 1;
    % stop when the relative error in the computed solution is greater than 1
    while reltiveError <= 1
        [A,b, reltiveError,relativeResidual,condintion,determinant] = gauss(iteration);
        if iteration == 3
            disp(A);
            disp(b);
        end
        % format output
        disp(sprintf(formatSpec,iteration,reltiveError,relativeResidual,condintion,determinant))
        iteration = iteration + 1;
    end
    diary off

function [A, b, reltiveError,relativeResidual,condintion,determinant] = gauss(n)
    
    % intialize A, b
    A = zeros(n,n);
    b = zeros(n,1);
    rel = zeros(n,1);
    for row = 1:1:n
        for col = 1:1:n
            A(row, col) = power(col,row);
            b(row,1) = b(row,1)+power(-1,col+1)*A(row, col);
        end
        rel(row,1) = power(-1, row+1);
    end
    % calculate Ax = b 
    x = A\b;
    % calcuate reltive error using 2-norm
    reltiveError = norm(rel-x, 2)/norm(rel,2);
    % calculate relative residual using 2-norm
    relativeResidual = norm(b-A*x, 2)/norm(b,2);
    % calculate conditional number for A
    condintion = cond(A,2);
    % calculate the determinant
    determinant = det(A);