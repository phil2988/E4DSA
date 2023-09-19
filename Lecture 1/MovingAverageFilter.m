clear all;
close all;

x = ones(1,10000);%[1,1,1,1,5,5,5,5];
middelstoj=0;
stsafvigelse=0.3;



N=length(x);

stojw=stsafvigelse.*randn(1,N);
x=x+stojw;
M=3;


ymem=zeros(1,M-1);

for n=1:N
    y(n)=x(n)+sum(ymem);
    ymem=[x(n), ymem(1:end-1)];
end

y=y./M;

%plot(y)
%hold on
%plot(x)
var(stojw)
var(y)