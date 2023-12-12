clc; clear;

%% Task 1
fs = 48000;
t1 = 0.01;
t0 = 0:1/fs:t1;
f0 = 1000;
f1 = 5000;
signal_chirp = 0.9*chirp(t0,f0,t1,f1);
f0 = figure;
plot(signal_chirp);
title("Chirp signal", 'FontSize', 30)
xlabel("Samples", 'FontSize', 16)
ylabel("Amplitude", 'FontSize', 16)

% soundsc(y)

%% Task 3

% Load the data
data_10cm = load("chirpData\10cm.dat");
data_40cm = load("chirpData\40cm.dat");
data_70cm = load("chirpData\70cm.dat");

% Plot the data

f1 = figure;
plot(data_10cm);
title("Chirp signal response (10cm)", 'FontSize', 30)
xlabel("Samples", 'FontSize', 16)
ylabel("Amplitude", 'FontSize', 16)

f2 = figure;
plot(data_40cm);
title("Chirp signal response (40cm)", 'FontSize', 30)
xlabel("Samples", 'FontSize', 16)
ylabel("Amplitude", 'FontSize', 16)

f3 = figure;
plot(data_70cm);
title("Chirp signal response (70cm)", 'FontSize', 30)
xlabel("Samples", 'FontSize', 16)
ylabel("Amplitude", 'FontSize', 16)

%% Task 4
signal_N = length(data_10cm);
time_vector = 0:fs/signal_N:fs-fs/signal_N;

% Transform the data
data_10cm_fft = abs(fft(data_10cm));
data_40cm_fft = abs(fft(data_40cm));
data_70cm_fft = abs(fft(data_70cm));

% Plot the transformed data
f4 = figure;
plot(time_vector, data_10cm_fft);
title("Chirp signal response (10cm) - Frequency domain ", 'FontSize', 30)
xlabel("Frequency (Hz)", 'FontSize', 16)
ylabel("Amplitude", 'FontSize', 16)
xlim([0, 12000])

f5 = figure;
plot(time_vector, data_40cm_fft);
title("Chirp signal response (40cm) - Frequency domain ", 'FontSize', 30)
xlabel("Frequency (Hz)", 'FontSize', 16)
ylabel("Amplitude", 'FontSize', 16)
xlim([0, 12000])

f6 = figure;
plot(time_vector, data_70cm_fft);
title("Chirp signal response (70cm) - Frequency domain ", 'FontSize', 30)
xlabel("Frequency (Hz)", 'FontSize', 16)
ylabel("Amplitude", 'FontSize', 16)
xlim([0, 12000])

fs = 48000; % 48 khz
f0  = 0;
f1 = 3000;
T  = 1/fs;
L  = 500; % Length of chirp
t  = (0:L-1)/fs;
other_chirp = chirp(t, f0, (L-1)/fs, f1);

% CC the chirp and data
[Rxy_10cm, tau_10cm] = myCC(data_10cm, other_chirp);
[Rxy_40cm, tau_40cm] = myCC(data_40cm, other_chirp);
[Rxy_70cm, tau_70cm] = myCC(data_70cm, other_chirp);

% Plot the data
f7 = figure;
plot(tau_10cm, Rxy_10cm);
title("Chirp signal Cros Coalated with data at 10cm", 'FontSize', 30)
xlabel("Sample Difference (tau)", 'FontSize', 16)
xlim([-500, 1500])

f8 = figure;
plot(tau_40cm, Rxy_40cm);
title("Chirp signal Cros Coalated with data at 40cm", 'FontSize', 30)
xlabel("Sample Difference (tau)", 'FontSize', 16)
xlim([-500, 1500])

f9 = figure;
plot(tau_70cm, Rxy_70cm);
title("Chirp signal Cros Coalated with data at 70cm", 'FontSize', 30)
xlabel("Sample Difference (tau)", 'FontSize', 16)
xlim([-500, 1500])


%% Functions
% Cross coalition implementation
function [Rxy,Tau] = myCC(x,y)
    len = max((((length(x)-1)*2)+1), (((length(y)-1)*2)+1));
    tau = zeros(1,len);
    rxy = zeros(1,len);
    
    for i = 1:len
        mi = i-((len-1)/2)-1;
        Tau(i) = mi;
        addRxy = 0;
        for j = 1:length(x)
            if (mi+j > 0 && mi+j <= length(y))
                add = x(j)*y(mi+j);
            else
                add = 0;
            end
            addRxy = addRxy + add;
        end
        Rxy(len-i+1) = addRxy;
    end
end

