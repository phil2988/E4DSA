clear all; close all; clc;

% Der er givet et signal x[n] = u[n] + w[n] hvor u[n] er step input og 
% w[n] er et i.i.d. (independent identically distributed) signal, 
% som er normalfordelt med middelværdi μ = 0 og standard afvigelse σ = 0.3.

% Standard afvigelse
sigma = 0.3;

% Middelværdi
my = 0;

%% a) Tegn 100 samples af x[n] med matlab.

n = 100;

signal = x(n);

% Plot x

plot(signal,'b-', 'LineWidth', 1.5);
hold on

ylabel('Spænding [V]')
xlabel('n')
ylim([-1 2])


%% b) Vælg filterorden M=5. Tegn filtrets impulsrespons af filtret h[n].
% Vi dæmper støjen fra signalet vha. et moving average midlingsfilter.

reduced = ma(x(n), n);
response = maResponse(x(n), n);

% Plot reduced
yline(reduced,'g-', 'LineWidth', 1)

plot(response)
hold off

%% Define functions

% 0 til 1 step værdi
function u = u(n) 
    u = [zeros(n/2,1);ones(n/2,1)];
end

% random iid signal
function w = w(n) 
    w = 0.3*randn(n,1)+0;
end

% define x(n)
function x = x(n)
    x = u(n) + w(n);
end

function ma = ma(f, n)
    values = 0;
    for i = 1 : n
        values = values + f(i);
    end
    ma = values * (1 / n);
end

function response = maResponse(f, n)
    normalized = normalize(f);
    response = abs((1/n) * abs(sin(pi * normalized(n)) / (pi * normalized(n))));  
end

