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
frequency_axis = 0:fs/N_signal:fs-fs/N_signal;

f1 = figure;
plot(frequency_axis(1:length(frequency_axis)/2), signal_fft(1:length(signal_fft)/2))
title("Signal in the frequence domain", 'FontSize', 30)
ylabel("Amplitude", 'FontSize', 16)
xlabel("Frequence", 'FontSize', 16)

% Spectrogram
f2 = figure;
spectrogram(signal, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the signal", 'FontSize', 30);
ylim([0, 3]);

%% Task 2
% Creating the filter

% Coefficients
b0 = 1;
b1 = -1.989441;
b2 = 1;
a1 = 1.979996;
a2 = -0.9801;

% Combining the coefficients
b = [b0, b1, b2];
a = [a1, a2];

% The filter's frequency response
[freq_respons, axis] = freqz(b, a, 2.^16);
axis = axis * fs/(2*pi);

%Frekvensresponesn plottes
f3 = figure;
plot(axis, mag2db(abs(freq_respons)));
title('Frequency response (|H(ej)|)', 'FontSize', 30);
ylabel('Magnitude [dB]', 'FontSize', 16);
xlabel('Frequency [Hz]', 'FontSize', 16);
xlim([0 1500]);

%Filtrering og fft af filtreret og ufiltreret signal
[signal_filtered, zf] = filter([b0 b1 b2], [a1 a2], signal);

N_signal_filtered = length(signal_filtered);

signal_filtered_fft = abs(fft(signal_filtered));

frequency_axis_filtered = 0:fs/N_signal_filtered:fs-fs/N_signal_filtered;

%Plot af det ufiltrerede signal
f4 = figure;
plot(frequency_axis, signal_fft);
title('Unfiltered signal zoomed in', 'FontSize', 30);
xlabel('Frequency [Hz]', 'FontSize', 16);
ylabel('Magnitude', 'FontSize', 16);
xlim([0 1500]);

%Plot af det filtrerede signal
f5 = figure;
plot(frequency_axis_filtered, signal_filtered_fft);
hold on
title('Filtered signal zoomed in', 'FontSize', 30);
xlabel('Frekvens [Hz]', 'FontSize', 16);
ylabel('Magnitude', 'FontSize', 16);

xlim([0 1500]);
hold off