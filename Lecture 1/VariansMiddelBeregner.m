clear all
close all
stdafv = 5;
middelv =8;
N=1000;

x = stdafv.*randn(1,N)+middelv;

%Estimation middel:

x_avg = 1./N.*sum(x)

%Estimation varians

hatsigma2 = 1./(N-1).*sum((x-x_avg).^2)

%Estimation Standard afvigelse

hatsigma = sqrt(hatsigma2)




%% Alternativ implementering 2

x_avg = 0;

for n = 1:length(x)
    x_avg = x_avg + x(n);
end
x_avg = x_avg/length(x)

hatsigma2 = 0;

for n = 1 :length(x)
    hatsigma2 = hatsigma2 + (x(n)-x_avg)^2;
end

hatsigma2 = hatsigma2/(length(x)-1)

hatsigma = sqrt(hatsigma2)

%% Alternativ implementering 3

x_avg = mean(x)

hatsigma2 = var(x)

hatsigma = sqrt(hatsigma2)