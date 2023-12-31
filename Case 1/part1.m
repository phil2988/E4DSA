clear, clc, close all;
%% Initialization
% Load data into variable
f0 = figure;
data = load('vejecelle_data.mat').vejecelle_data;
fs = load('vejecelle_data.mat').fs;

plot(data, 'r-')
xlabel("samples")
ylabel("weight (g)")
title("Weight measured from a load cell with the mean visualized")
hold on

data_unloaded = data(1:1000);
data_loaded = data(1050:length(data));

%% Finding the mean of the loaded and unloaded data
mean_unloaded = getMean(data_unloaded);
yline(mean_unloaded, 'g', 'LineWidth', 2)

mean_loaded = getMean(data_loaded);
yline(mean_loaded, 'g', 'LineWidth', 2)
hold off

%% Finding the standard deviation
f1 = figure;
plot(data, 'r-')
hold on
xlabel("samples")
ylabel("weight (g)")
title("Weight measured from a load cell with the standar deviation visualized")

% Calculate the deviation
std_unloaded = getStandardDeviation(data_unloaded);
std_loaded = getStandardDeviation(data_loaded);

% Visualize the deviation by adding a line
% indicating the upper and lower bounds of deviation
yline(mean_unloaded + std_unloaded, 'b-', 'LineWidth', 2)
yline(mean_unloaded - std_unloaded, 'b-', 'LineWidth', 2)

yline(mean_loaded + std_loaded, 'b-', 'LineWidth', 2)
yline(mean_loaded - std_loaded, 'b-', 'LineWidth', 2)
hold off

%% Finding the variance

% Calculate the variance
var_unloaded = getVariance(data_unloaded);
var_loaded = getVariance(data_loaded);

%% Histograms of the loaded and unloaded data
f2 = figure;
x = tiledlayout(1, 2);
title(x, "Histogram of loaded and unloaded data")

f1 = nexttile;
histogram(data_unloaded);
title(f1, "Unloaded (std ~ 28)")
xlabel(f1, "Weight(g)")
ylabel(f1, "Samples")

hold on
xline(mean_unloaded - std_unloaded);
xline(mean_unloaded + std_unloaded);
hold off

f2 = nexttile;
histogram(data_loaded);
title(f2, "Loaded (std ~ 27.5)")
xlabel(f2, "Weight(g)")
ylabel(f2, "Samples")

hold on
xline(mean_loaded - std_loaded);
xline(mean_loaded + std_loaded);
hold off

%% Frequency spectrums of the loaded data
f3 = figure;

% Doing a fft on the data
data_loaded_fft = fft(data_loaded);

% Normalize the FFT result
data_loaded_fft = data_loaded_fft / length(data_loaded);

% Creating the frequency axis
frequency_axis = (-fs/2:fs/length(data_loaded):(fs/2-fs/length(data_loaded)));

% Plot the fft data
absed = abs(data_loaded_fft);

% Plot without the DC point
plot(frequency_axis(2:length(frequency_axis)), abs(data_loaded_fft(2:length(data_loaded_fft))))
xlabel('Frequency (Hz)', 'FontSize', 16);
ylabel('Magnitude', 'FontSize', 16);
title('Frequency Spectrum of loaded Load Cell Data', 'FontSize', 16);

%% Using a moving average filter on the loaded signal

ma_data_10 = ma(data_loaded, 10);
ma_data_50 = ma(data_loaded, 50);
ma_data_100 = ma(data_loaded, 100);

% Plotting data with slope
f4 = figure;
title("Moving average filters used on data", 'FontSize', 16)
ylabel("Weight(g)", 'FontSize', 16)
xlabel("Samples", 'FontSize', 16)

hold on

plot(data_loaded)
plot(ma_data_10)
plot(ma_data_50)
plot(ma_data_100)

legend("no filter", "10th order", "50th order", "100th order")

hold off

% Plotting data without slope
f5 = figure;
title("Moving average filters used on data without slope", 'FontSize', 16)
ylabel("Weight(g)", 'FontSize', 16)
xlabel("Samples", 'FontSize', 16)

hold on

plot(data_loaded, 'LineWidth', 1.2)
plot(ma_data_10(10:length(ma_data_10)), 'LineWidth', 1.2)
plot(ma_data_50(50:length(ma_data_50)), 'LineWidth', 1.2)
plot(ma_data_100(100:length(ma_data_100)), 'LineWidth', 1.2)

legend("no filter", "10th order", "50th order", "100th order")

hold off

%% Plots of histograms and variance
f5 = tiledlayout(1,3);
title(f5, "Histogram of loaded data after MA filter", 'FontSize', 16);

h0 = nexttile;
histogram(ma_data_10(10:length(ma_data_10)), 'BinWidth',3)
title(h0, "10th order", 'FontSize', 16);
xlabel(h0, "Weight(g)", 'FontSize', 16);
ylabel(h0, "Samples", 'FontSize', 16);
xlim([1360, 1440])

h1 = nexttile;
histogram(ma_data_50(50:length(ma_data_50)), 'BinWidth',3)
title(h1, "50th order", 'FontSize', 16);
xlabel(h1, "Weight(g)", 'FontSize', 16);
ylabel(h1, "Samples", 'FontSize', 16);
xlim([1360, 1440])

h2 = nexttile;
histogram(ma_data_100(100:length(ma_data_100)), 'BinWidth',3)
title(h2, "100th order", 'FontSize', 16);
xlabel(h2, "Weight(g)", 'FontSize', 16);
ylabel(h2, "Samples", 'FontSize', 16);
xlim([1360, 1440])

mean_ma_data_10 = getMean(ma_data_10(10:length(ma_data_10)));
mean_ma_data_50 = getMean(ma_data_50(50:length(ma_data_50)));
mean_ma_data_100 = getMean(ma_data_100(100:length(ma_data_100)));

var_ma_data_10 = getVariance(ma_data_10(10:length(ma_data_10)));
var_ma_data_50 = getVariance(ma_data_50(50:length(ma_data_50)));
var_ma_data_100 = getVariance(ma_data_100(100:length(ma_data_100)));

std_ma_data_10 = getStandardDeviation(ma_data_10(10:length(ma_data_10)));
std_ma_data_50 = getStandardDeviation(ma_data_50(50:length(ma_data_50)));
std_ma_data_100 = getStandardDeviation(ma_data_100(100:length(ma_data_100)));

%% Max slope of 100ms
ma_data_30 = ma(data_loaded, 30);

f6 = figure;

plot(ma_data_100,'LineWidth', 2)
title("Moving average filters used on data (30th order)", 'FontSize', 16);
ylabel("Weight(g)", 'FontSize', 16);
xlabel("Samples", 'FontSize', 16);
xline(100,'LineWidth', 2);
xlim([0, 500]);

%% Using the exponential smoothening filter on the loaded data
exp_data_005 = exp_filter(data_loaded, 0.05);

f7 = figure;

plot(exp_data_005, 'LineWidth', 2)

title("Exponential smoothening filter used on loaded data", 'FontSize', 16)
ylabel("Weight(g)", 'FontSize', 16)
xlabel("Samples", 'FontSize', 16)

% Trying a biger alpha
exp_data_05 = exp_filter(data_loaded, 0.5);
f8 = figure;

plot(exp_data_05, 'LineWidth', 2)

title("Exponential smoothening filter used on loaded data", 'FontSize', 16)
ylabel("Weight(g)", 'FontSize', 16)
xlabel("Samples", 'FontSize', 16)

%% Comparing moving average and exponential
f9 = figure;
exp_data_00198 = exp_filter(data_loaded, 0.0198);

hold on
plot(ma_data_100,'LineWidth', 1.3);
plot(exp_data_00198,'LineWidth', 1.3);
hold off

title("100th order Moving average and 0.0198 alpha Exponential filter", 'FontSize', 16)
ylabel("Weight(g)", 'FontSize', 16)
xlabel("Samples", 'FontSize', 16)
xlim([0, 500])

legend("Moving Average", "Exponential")


%% Functions

% Calculate the mean of a signal
function m = getMean(data)
    N = length(data);
    summed = 0;
    for i = 1:N
        summed = summed + data(i);
    end
    m = (1/N) * summed;
end

% Calculate the variance of a signal
function v = getVariance(data)
    N = length(data);
    summed = sum((data-getMean(data)).^2);
    v = 1/(N-1) * summed;
end

% Calculate the standard deviation of a signal
function std = getStandardDeviation(data)
    N = length(data);
    summed = sum((data-getMean(data)).^2);
    var = 1/(N) * summed;
    std = sqrt(var);
end

% Moving Average Filter
function average = ma(data, order)
    zeroData = [zeros(1, order-1) data];
    average = 1:length(data);
    % Cycle through the data one at a time
    for i = order:length(zeroData)
        % Take the mean of a data slice of size order
        summed = sum(zeroData(i-order+1:i));
        average(i-(order - 1)) = summed/order;
    end
end

function smoothed_data = exp_filter(data, alpha)
% Exponential Smoothing Filter
%   data:       Input time series data (vector)
%   alpha:      Smoothing factor (0 < alpha < 1)

    % Initialize the smoothed_data vector with the same length as data
    smoothed_data = zeros(size(data));
    
    % Apply exponential smoothing
    for t = 2:length(data)
        smoothed_data(t) = alpha * data(t) + (1 - alpha) * smoothed_data(t-1);
    end
end


