function ThreeC
bases = {'1./(1+t.^2)' 'exp(-t.^2)'};

eva = linspace(-2, 2, 201);
p = linspace(-2, 2, 13);

f = inline(bases{1}, 't');
S = polyfit(p, f(p), 12);
subplot(2,2,1);
plot(eva, f(eva), eva , polyval(S , eva ));
legend('f', 'Sf');
title('fig. 1')
err = abs(f(eva)-polyval(S , eva ));
subplot(2,2,3);
plot(eva, err);
legend('err f');
title('fig. 3')

g = inline(bases{2}, 't');
S = polyfit(p, g(p), 12);
subplot(2,2,2);
plot(eva, g(eva), eva , polyval(S , eva ));
legend('g', 'Sg');
title('fig. 2')
err = abs(g(eva)-polyval(S , eva ));
subplot(2,2,4);
plot(eva, err);
legend('err g');
title('fig. 4')

