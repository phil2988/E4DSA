clc; clear;

%% TASK 1
% Generate the FSK Signal
fstart = 1000; % transmission band frequency start
fend = 5000; % transmission band frequency end
Tsymbol = 0.5; % symbol duration in seconds
fs = 20000; % sampling frequency

signal = FSKgenerator('phillip', fstart, fend, Tsymbol, fs);
signal_N = length(signal);

% part 2
signal_fft = abs(fft(signal));

x_frequence = 0:fs/signal_N:fs-fs/signal_N;

plot(x_frequence(1:length(x_frequence)/2), signal_fft(1:length(signal_fft)/2))
title("FSK-Signal in the frequence domain", 'FontSize', 16)
ylabel("Amplitude", 'FontSize', 16)
xlabel("Frequence", 'FontSize', 16)
xlim([2550,2800])

time_vector = (0:signal_N - 1)/fs;

f1 = figure;
plot(time_vector, signal)
title("FSK-Signal in the time domain", 'FontSize', 16)
ylabel("Amplitude", 'FontSize', 16)
xlabel("Time(s)", 'FontSize', 16)
xlim([1.1, 1.105])
ylim([-1.5, 1.5])

f2 = figure;
spectrogram(signal, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal", 'FontSize', 16)

