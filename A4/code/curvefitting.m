


% Curve Fitting  

% use linear method base on target duration and maximum yield to maturity (YTM)
% 02.11.2006, Sofia
% Peter Radkov

% ===============================================
% input data 
                 
% dataT(1,i) = w(i) weights
% dataT(3,i) = a(i) maturity in years
% dataT(2,i) = b(i) value / yield

data=[615 1550 1350 1600 1550 1288 800 1850 1800 1400 1600 2350 2100 750 1109 3100 3600 2850 3658 1250 1252 1548 2609 1806 3075 1000 1620 1362 992 1800 3150 1446 2521 1000 223 700 1000
    12.13 11.93 11.60 11.65 11.38 11.45 11.14 11.13 11.04 10.87 10.86 10.86 10.89 10.62 10.74 10.81 10.71 10.78 10.88 10.63 10.75 10.76 10.57 10.67 10.65 10.56 10.86 10.50 10.48 10.44 10.59 10.29 10.17 10.20 10.18 10.19 10.19
    0.010 0.293 0.419 1.619 1.764 1.832 2.610 2.769 3.569 3.920 3.356 4.545 4.038 5.690 5.353 6.621 6.147 7.531 7.367 8.520 8.868 8.372 9.660 10.638 11.145 12.169 10.704 13.304 14.786 15.249 12.542 16.032 17.273 18.221 20.024 24.561 22.441];


% ===============================================
% 1.BEST FIT SPLINES
% the seed points 

seed_points=[0 3 7 10 30];

c=[1,2,3
    2,2,2
    3,3,1];
%C

    
seed_point=length(seed_points);

dataT=data';
seed_pointsT=seed_points';

% the nearest neighbours

% g(i,j)=([a(i)-s(i)]^2)/w(i) ---> matrix G

G=ones(length(dataT),seed_point);

for j=1:length(seed_pointsT)
    for i=1:(size(dataT,1))
        G(i,j)=((dataT(i,3)-seed_pointsT(j,1))^2)/(dataT(i,1));
    end 
end

M=G;

T=ones(2,length(seed_pointsT))*10;

t=zeros(2,length(seed_pointsT));


for k=1:size(G,2)'
    for j=1:2
        for i=1:(size(dataT,1))            
            if M(i,k)>T(j,k)
            else 
                T(j,k)=G(i,k);
                t(j,k)=i;
                p=i;
            end
        end
        M(p,k)=20;      
    end
end
    
% r(j) - average yield weighted point with w(i)
% u(j) - average maturity weighted point with w(i)

r=zeros(seed_point,1);  % yield 
m=zeros(seed_point,1);  % maturity      

for j=1:seed_point
    
     r(j,1)=(dataT((t(1,j)),1)*dataT((t(1,j)),2)+dataT((t(2,j)),1)*dataT((t(2,j)),2))/(dataT((t(1,j)),1)+dataT((t(2,j)),1));
     m(j,1)=(dataT((t(1,j)),1)*dataT((t(1,j)),3)+dataT((t(2,j)),1)*dataT((t(2,j)),3))/(dataT((t(1,j)),1)+dataT((t(2,j)),1));
        
end

rT=r';      % yield
mT=m';      % maturity

% allocation of remaining data points to clusters
% ---> matrix H 

H=zeros(length(dataT),length(seed_points));
l=0.5;      % l 

for i=1:length(dataT)
    for j=1:length(seed_points)
        if i==t(1,j)
            H(i,j)=0;
        elseif i==t(2,j)
            H(i,j)=0;
        else
            H(i,j)=((dataT(i,3)-mT(1,j))^2)+l*((dataT(i,2)-rT(1,j))^2);
        end
    end 
end


C=zeros(length(dataT),1);


for i=1:length(dataT)

    h=H(i,:);
    
    k=100;
    q=0;
    for j=1:length(h)
        if h(1,j)<k
            k=h(1,j);
            q=j;
        else
        end
    end
    C(i,1)=q;        
end


% the sentral point of each cluster

x1=zeros(1,length(seed_points));
y1=zeros(1,length(seed_points));


for j=1:length(seed_points)

    v=zeros(length(dataT),1);
    v_sum=0;

    for i=1:length(dataT)
        if C(i,1)==j
            v(i,1)=dataT(i,1);
            v_sum=v_sum+dataT(i,1);
        else
            v(i,1)=0;
        end
    end
    x1(1,j)=(v'*(dataT(:,3)))*(v_sum^(-1));
    y1(1,j)=(v'*(dataT(:,2)))*(v_sum^(-1));
    
end

x=x1';          % x term to maturity 
y=y1';          % y yield to maturity


coupon=[0;3.5;3.5;2.5;3.5;5;3.75;4.25;3.25;4;3.75;6.5;4;4];


% ===============================================
% 2.NATURAL CUBIC SPLINES

% find out coefficent b

s=size(x,1);

j=zeros(s,1);
m=zeros(s,1);
n=zeros(s,1);
p=zeros(s,1);
q=zeros(s,1);


for i=1:s
    j(i,1)=i-1;
    if i==1
        p(i,1)=0;
        q(i,1)=0;
        m(i,1)=x(i+1,1)-x(i,1);
        n(i,1)=y(i+1,1)-y(i,1);
    elseif i==s
        m(i,1)=0;
        n(i,1)=0;
        p(i,1)=0;
        q(i,1)=0;
    else
        m(i,1)=x(i+1,1)-x(i,1);                         
        n(i,1)=y(i+1,1)-y(i,1);
        p(i,1)=2*(m(i-1,1)+m(i,1));
        q(i,1)=3*(n(i,1)/m(i,1)-(n(i-1,1)/m(i-1,1)));
    end
end

A=[j,x,y,m,n,p,q];


P=zeros(s-2,s-2);
q1=zeros(s-2,1);

for i=1:s-2
    for j=1:s-2
        if i==j
            P(i,j)=p(i+1,1);
        elseif abs(i-j)==1
            P(i,j)=m(i,1);
        else 
            P(i,j)=0;
        end   
    end
    q1(i,1)=q(i+1,1);
end

b1=zeros(s-2,1);
a=zeros(s,1);
b=zeros(s,1);
c=zeros(s,1);

b1=P\q1;

for i=1:s-2
    b(i+1,1)=b1(i,1);
end

for i=1:s
    if i==s 
        a(i,1)=0;
        c(i,1)=0;
    else 
        a(i,1)=n(i,1)/m(i,1)-m(i,1)*(b(i+1,1)+2*b(i,1))/3;
        c(i,1)=(b(i+1,1)-b(i))/(3*m(i,1));
    end
end

B=[a,b,c];
B;

le=round((x(length(x),1)-x(1,1))*100);

Mat=zeros(le,1);          % maturity
YTM=zeros(le,1);          % yield

t=1;

for i=1:s
    if i==s 
    else 
        k=round(x(i+1,1)*100)-round(x(i,1)*100);

      %   if k==1 
      %      Mat(t,1)=x(i,1);
      %      YTM(t,1)=y(i,1);
      %      Mat(t+1,1)=x(i+1,1);
      %      YTM(t+1,1)=y(i+1,1);
      %      t=t+1;
      %      else
      
            for r=0:(k)
                Mat(t+r,1)=x(i,1)+r/100;
                if r==0 
                    YTM(t+r,1)=y(i,1);
                else
                    YTM(t+r,1)=y(i,1)+a(i,1)*(r/100)+b(i,1)*(r/100)^2+c(i,1)*(r/100)^3;
                end
            end
        t=t+k;
      % end
      % YTM(x(length(x),1),1)=y(length(x),1);
    end
end

[Mat,YTM];                         
plot(Mat,YTM,'-',x,y,'ro',dataT(:,3),dataT(:,2),'o');                    





zy=zeros(x(length(x),1),1);
fy=zeros(x(length(x),1),1);


'zero coupon yield curve (zy)'


for i=1:s
   if coupon(i,1)==0
       zy(i,1)=y(i,1);
  else 
   end 
  end

for i=1:C(x(length(x),1))
  if zy(i,1)==0
      d=0;
     for j=1:i-1
         d=d+C1(i,1)/((1+C1(j,1)/100)^(j));
    end
     
    zy(i,1)=(((100+C1(i,1))/(100-d))^(1/i)-1)*100;
    else
    end
        
    end

for i=1:C(x(length(x),1))
    
   if i==length(C)
       fy(length(C),1)=zy(length(C),1);    
  else 
       fy(i,1)=(((1+zy(i+1,1)/100)^2)/(1+zy(i,1)/100)-1)*100;
  end
  end



[C,C1,zy,fy];
plot(C,zy,C,C1,C,fy);
