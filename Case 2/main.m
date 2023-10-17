clc; clear;

%% TASK 1
% part 1
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


% part 3
f2 = figure;
spectrogram(signal, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal", 'FontSize', 16)

% part 4.1
signal_low_fstart = FSKgenerator('phillip', 100, fend, Tsymbol, fs);
signal_high_fstart = FSKgenerator('phillip', 10000, fend, Tsymbol, fs);

f3 = figure;
spectos_fstart = tiledlayout(1, 2);
title(spectos_fstart , " Spectrograms for the FSK-Signal", 'FontSize', 28)

spec1 = nexttile;
spectrogram(signal_low_fstart, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal - Low f-start", 'FontSize', 16)

spec2 = nexttile;
spectrogram(signal_high_fstart, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal - High f-start", 'FontSize', 16)

% part 4.2
signal_low_fend = FSKgenerator('phillip', fstart, 500, Tsymbol, fs);
signal_high_fend = FSKgenerator('phillip', fstart, 50000, Tsymbol, fs);

f4 = figure;
spectos_fend = tiledlayout(1, 2);
title(spectos_fend , " Spectrograms for the FSK-Signal", 'FontSize', 28)

spec3 = nexttile;
spectrogram(signal_low_fend, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal - Low f-end", 'FontSize', 16)

spec4 = nexttile;
spectrogram(signal_high_fend, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal - High f-end", 'FontSize', 16)

% part 4.3
signal_low_tsymbol = FSKgenerator('phillip', fstart, fend, 0.05, fs);
signal_high_tsymbol = FSKgenerator('phillip', fstart, fend, 5, fs);

f5 = figure;
spectos_tsymbol = tiledlayout(1, 2);
title(spectos_tsymbol , " Spectrograms for the FSK-Signal", 'FontSize', 28)

spec5 = nexttile;
spectrogram(signal_low_tsymbol, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal - Low t-symbol", 'FontSize', 16)

spec6 = nexttile;
spectrogram(signal_high_tsymbol, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal - High t-symbol", 'FontSize', 16)

% part 4.4
signal_low_fs = FSKgenerator('phillip', fstart, fend, Tsymbol, 2000);
signal_high_fs = FSKgenerator('phillip', fstart, fend, Tsymbol, 200000);

f6 = figure;
spectos_fs = tiledlayout(1, 2);
title(spectos_fs , " Spectrograms for the FSK-Signal", 'FontSize', 28)

spec6 = nexttile;
spectrogram(signal_low_fs, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal - Low fs", 'FontSize', 16)

spec7 = nexttile;
spectrogram(signal_high_fs, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal - High fs", 'FontSize', 16)




