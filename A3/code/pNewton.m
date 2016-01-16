function root = pNewton(iteration)
% iteration: ieration times
% f: input function

x = rand();

figure
hold on;

title(['Newton`s Method     intinal gauss:',num2str(x)]);

root = x;
right = x;
left = 0;

for i = 0:iteration
    % calculate root
    % eliminate division by x 
    root = x - f(x)/x;
    % update color
    color = floor(i/iteration);
    % plot root
    rangeX = [x, x];
    rangeY = [0 f(x)];
    plot(rangeX,rangeY,'Color',[color 0 1-color]);
    %plot tanget line
    rangeX = [x root];
    rangeY = [f(x) 0];
    plot(rangeX,rangeY,'Color',[color 0 1-color])
    % update right and left(total x-axis range)
    right = max(right, root);
    left = min(left, root);
    %update x
    x = root;
end
% plot f(x)
a = linspace(left,right,1001);
b = f(a);
plot(a,b,'black');
line([left right], [0 0]);

function r = f(x)
%f(x)
r = nthroot((1 - 3*power(4*x,-1)), 3); 
