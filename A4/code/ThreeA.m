


function ThreeA
bases = {'1./(1+t.^2)' 'exp(-t.^2)'};

for i = 1:2
    f = inline(bases{i}, 't');
    v = linspace(-2, 2, 201);
    plot(v , f(v));    
    hold on;
end
legend('1/(1+t.^2)', 'exp(-t^2)'); 
