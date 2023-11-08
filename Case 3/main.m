clc; clear;

%% Task 1

% Loading and plotting the audio file
[signal, fs] = audioread("tale_tone_48000.wav");

N_signal = length(signal);
time_vector = (0:N_signal - 1)/fs;

% Plot in time domain
f0 = figure;
plot(time_vector, signal);
title("Speaking tone signal", 'FontSize', 30)
xlabel("Time(s)", 'FontSize', 16)
ylabel("Amplitude", 'FontSize', 16)

% Plot in frequency domain
signal_fft = abs(fft(signal));
x_frequence = 0:fs/N_signal:fs-fs/N_signal;

f1 = figure;
plot(x_frequence(1:length(x_frequence)/2), signal_fft(1:length(signal_fft)/2))
title("Signal in the frequence domain", 'FontSize', 30)
ylabel("Amplitude", 'FontSize', 16)
xlabel("Frequence", 'FontSize', 16)

% Spectrogram
f2 = figure;
spectrogram(signal, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the signal", 'FontSize', 30);
ylim([0, 3]);

