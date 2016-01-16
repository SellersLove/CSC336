function output = naturalSpline(x,y,xx) 

n = length(x); 
% coffe matrix
C0 = 2 * n - 2;
C1 = 2 * n - 2;
C2 = 3 * n - 4;
A = zeros(4*(n-1));
b = zeros(4*(n-1),1);
% intiall the C0
for i = 1:2:C0
    j = fix(i/2);
    start = j * 4 + 1;
    ends  = start + 3;
    A(i,start:ends) = [power(x(j+1),3) power(x(j+1),2) x(j+1) 1];
    b(i) = y(j+1);
    A(i+1,start:ends) = [power(x(j+2),3) power(x(j+2),2) x(j+2) 1];
    b(i+1) = y(j+2);
end 
% intiall the C1 1 : n-1
for i = 1 : n-2
    start = (i - 1)*4 +1;
    ends  = start + 2;
    A(i+C1,start:ends) = [3*power(x(j+1),2) 2*x(j+1) 1];
    A(i+C1,start+4:ends+4) = [-3*power(x(j+1),2) -2*x(j+1) -1];
end
% intiall C2
for i = 1 : n-2
    start = (i - 1)*4 +1;
    ends  = start + 1;
    A(i+C2,start:ends) = [6*x(j+1) 2];
    A(i+C2,start+4:ends+4) = [-6*x(j+1) -2];
end
% end points
A(4*n-5,1:2) = [6*x(1) 2];
A(4*n-4,4*n-7:4*n-6) = [6*x(n) 2];
r = A \ b;
coeff = vec2mat(r, 4);
pp = mkpp(x, coeff, 1);
pp.dim = 1;
    
if nargin==2, output = pp; 
else
    len = length(xx);
    result = [];
    for i = 1:len
        for j = 1:len-1
            if x(j)<=xx(i) && xx(i)<= x(j+1)
                result(i) = coeff(j,1)*power(xx(i),3) + ...
                    coeff(j,2)*power(xx(i),2)+ coeff(j,3)* xx(i)...
                    + coeff(j,4);
                break
            end
        end
    end
end


