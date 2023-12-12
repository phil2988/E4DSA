clc; clear;

%% Task 1
fs = 48000;
t1 = 0.01;
t0 = 0:1/fs:t1;
f0 = 1000;
f1 = 5000;
y = 0.9*chirp(t0,f0,t1,f1);
plot(y);
title("Chirp signal", 'FontSize', 30)
xlabel("Samples", 'FontSize', 16)
ylabel("Amplitude", 'FontSize', 16)

soundsc(y)