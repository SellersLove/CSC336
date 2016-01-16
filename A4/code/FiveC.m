function FiveC
diary question3.out
test = [5,9,17,33,65,129];
eva = linspace(0,5,601);
f = inline('t.* exp(-t)', 't');
p = f(eva);
fprintf('    |Absolute Error: E = ||F(t)-S(t)||_2\n');
fprintf('%3s |%10s %11s %14s\n', 'n','natural','clamped','not-a-knot' );
fprintf('-------------------------------------------\n');
for i = 1:6
    data = linspace(0,5,test(i));
    pp = f(data); 
    % generate the spine on given 5 points
    ppNotknot = csape(data,pp,'not-a-knot');
    ppClamped = csape(data,pp,'clamped');
    
    % evaulates 'not-a-knot' spine function on 601 nodes
    notAknot = fnval(ppNotknot,eva);
    % evaulates 'clamped' spine function on 601 nodes
    clamped = fnval(ppClamped,eva);
    % evaulates 'clamped' spine function on 601 nodes
    natural = naturalSpline(data,pp,eva);
    errNatual = norm(p-natural, 2);
    errNotKnot = norm(p-notAknot,2 );
    errClamped = norm(p-clamped, 2);
    fprintf('%3d |%10e %10e %10e\n', test(i), errNatual, ...
    errClamped, errNotKnot);
end
diary off
