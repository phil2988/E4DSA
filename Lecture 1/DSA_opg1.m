%% DSA Lektion 1, Midlingsfilter
clear all
close all
clc

%% Generer data:

% initializer variable:

Stoj_middel=0;
Stoj_std_afv=0.3;

Antal_samples=100;
% x akse (sample numre)
n=0:Antal_samples-1;

%% Generer iid Normalfordelt støj

w=0.3*randn(Antal_samples,1)+0;

%% Test af støj:
%Estimeret middelværdi/gennemsnit
Est_mean=1/(Antal_samples).*sum(w);

%Estimeret varians
Est_var=1/(Antal_samples-1)*sum((w-Est_mean).^2);
Est_std_afv=sqrt(Est_var);

%% Generer signal

u=[zeros(50,1);ones(50,1)];

%% Støj og signal
x=u+w;

%% Plot x
plot(n,x,'x','linewidth', 2)
title('Plot af signal med støj')
ylabel('Spænding [V]')
xlabel('n')
hold on

plot(n,u,'linewidth',2)
%
grid

%% MA filter Matlab

FilterTaps=5;

xmem=zeros(FilterTaps-1,1);

for nn=1:length(x)
   
    xmem=[x(nn); xmem(1:end-1)];
    y(nn)=1/FilterTaps.*(sum(xmem)+x(nn));
end

plot(n,y,'linewidth',2)
legend('x[n]','u[n]','y[n]')