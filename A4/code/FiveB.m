
function FiveB
    data = linspace(0,5,6);
    eva = linspace(0,5,101);
    f = inline('t.* exp(-t)', 't');
    pp = f(data); 
    % generate the spine on given 5 points
    ppNotknot = csape(data,pp,'not-a-knot');
    ppClamped = csape(data,pp,'clamped');
    natural = naturalSpline(data,pp,eva);
    % evaulates 'not-a-knot' spine function on 101 nodes
    notAknot = fnval(ppNotknot,eva);
    % evaulates 'clamped' spine function on 101 nodes
    clamped = fnval(ppClamped,eva);
    % plot 'not-a-knot' and 'original' function
    subplot(2,3,1);
    plot(eva, natural, eva, f(eva) );
    legend('natural', 't.* exp(-t)');
    title('natural');
    subplot(2,3,4);
    plot(eva, abs(natural-f(eva)));
    title('natural error');
    subplot(2,3,2);
    plot(eva, clamped, eva, f(eva));
    legend('clamp', 't.* exp(-t)');
    title('clamped');
    subplot(2,3,5);
    plot(eva, abs(clamped-f(eva)));
    title('clamped error');
    subplot(2,3,3);
    plot(eva, notAknot, eva, f(eva));
    legend('not-a-knot', 't.* exp(-t)');
     title('not-a-knot');
    subplot(2,3,6);
    plot(eva, abs(notAknot-f(eva)));
    title('not-a-knot error');


    
    