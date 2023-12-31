clc; clear;

%% TASK 1
% part 1
fstart = 1000; % transmission band frequency start
fend = 5000; % transmission band frequency end
tsymbol = 0.5; % symbol duration in seconds
fs = 20000; % sampling frequency

signal = FSKgenerator('phillip', fstart, fend, tsymbol, fs);
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
signal_low_fstart = FSKgenerator('phillip', 100, fend, tsymbol, fs);
signal_high_fstart = FSKgenerator('phillip', 10000, fend, tsymbol, fs);

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
signal_low_fend = FSKgenerator('phillip', fstart, 500, tsymbol, fs);
signal_high_fend = FSKgenerator('phillip', fstart, 50000, tsymbol, fs);

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
signal_low_fs = FSKgenerator('phillip', fstart, fend, tsymbol, 2000);
signal_high_fs = FSKgenerator('phillip', fstart, fend, tsymbol, 200000);

f6 = figure;
spectos_fs = tiledlayout(1, 2);
title(spectos_fs , " Spectrograms for the FSK-Signal", 'FontSize', 28)

spec6 = nexttile;
spectrogram(signal_low_fs, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal - Low fs", 'FontSize', 16)

spec7 = nexttile;
spectrogram(signal_high_fs, 1024, 512, 512, fs, "yaxis")
title("Spectrogram for the FSK-Signal - High fs", 'FontSize', 16)

%% TASK 2
% part 1

fstart = 1000; % transmission band frequency start
fend = 5000; % transmission band frequency end
tsymbol = 0.5; % symbol duration in seconds
fs = 20000; % sampling frequency

other_signal = FSKgenerator('hello', fstart, fend, tsymbol, fs);

% pause(5)
% sound(other_signal, fs)

% part 2.1
[signal_recorded, fs_recorded] = audioread("Close.mp4");

start_seconds = 5.3;
length_seconds = 2.5;

signal_recorded = signal_recorded(fs_recorded * start_seconds:fs_recorded * (start_seconds + length_seconds));

signal_decoded = FSKDecoder(signal_recorded, fstart, fend, tsymbol, fs_recorded);

signal_decoded

% part 2.2
x = [5 1 2 6 7 1 2 5];

X_myDFT = myDFT(x)

X_matlab = fft(x)


%% TASK 3
% part 1

signal_decoded_N = length(signal_recorded)/5;

signal_decoded_character_h = signal_recorded(1:round(signal_decoded_N));

signal_decoded_character_h_SND_db_close = ...
    max(20.*log10(abs(fft(signal_decoded_character_h)))) - ...
    median(20.*log10(abs(fft(signal_decoded_character_h)))) - ...
    10.*log10(signal_decoded_N/2);

signal_decoded_character_h_SND_db_close

% part 2
[signal_recorded, fs_recorded] = audioread("Far.mp4");

start_seconds = 5.65;
length_seconds = 2.5;

signal_recorded = signal_recorded(fs_recorded * start_seconds:fs_recorded * (start_seconds + length_seconds));

signal_decoded_N = length(signal_recorded)/5;

signal_decoded_character_h = signal_recorded(1:round(signal_decoded_N));

signal_decoded_character_h_SND_db_far = ...
    max(20.*log10(abs(fft(signal_decoded_character_h)))) - ...
    median(20.*log10(abs(fft(signal_decoded_character_h)))) - ...
    10.*log10(signal_decoded_N/2);

signal_decoded_character_h_SND_db_far

% part 3

data = [10 signal_decoded_character_h_SND_db_close, 100 signal_decoded_character_h_SND_db_far]

f11 = figure;
hold on
plot( [10, 100], [signal_decoded_character_h_SND_db_close, signal_decoded_character_h_SND_db_far])
title("Signal to Noise ratio compared to distance recorded from speaker", 'FontSize', 30)
ylabel("SNR (db)", 'FontSize', 20)
xlabel("Distance (cm)", 'FontSize', 20)
ylim([40, 60])

%% FUNCTIONS
% part 2.1
function [char_output] = FSKDecoder(signal, fstart, fend, tsymbol, fs)
    trigger_level = 0.004;
    
    signal_N = length(signal);
    seconds = signal_N / fs;
    
    % Characters in seconds
    N_intervals = seconds / tsymbol;
    
    % Length of intervals in seconds
    interval_N = signal_N / N_intervals;
    
    % Splits frequency spectrum into 256 parts
    f_character = linspace(fstart + 1, fend, 256);
    
    % Size of the intervals in samples
    df = fs / interval_N;
    
    % Find the characters
    char_output = [];
    n_output = [];
    for i = 1:N_intervals
        fft_sig = fft(signal(i + (i - 1) * interval_N:i * interval_N));
        for n = 1:256
            % Match the character frequencies to the fft signal
            if((abs(fft_sig(round(f_character(n) / df)) / interval_N)) > trigger_level)
                % Adds the characters to the output
                char_output = [char_output char(round(n))];
                break
            end
        end
    end

end

% part 2.2
function [output] = myDFT(signal)
x = signal;
signal_N = length(x);

    for k = 1:signal_N
        X(k) = 0;
        for n = 1:signal_N
            X(k)=X(k)+x(n)*exp(((-2*pi*1i)/signal_N)*(k-1)*(n-1));
        end
    end
    
    output = X;
end