
function [reltiveError,relativeResidual] = generator2(x,n)

    for row = 1:1:n
        rel(row) = power(-1, row+1);
    end
    reltiveError = norm(rel-x, 2)/norm(rel,2);
