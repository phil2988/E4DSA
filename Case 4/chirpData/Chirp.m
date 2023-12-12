fs = 48000; % 48 khz
f0  = 0;
f1 = 3000;
T  = 1/fs;
L  = 500; % Length of chirp
t  = (0:L-1)/fs;
x = chirp(t, f0, (L-1)/fs, f1);
figure
subplot(2,1,1)
plot(x)
title('Chirp 0-3kHz, fs=48kHz')
subplot(2,1,2)
cm50 = load('50cm.dat');
plot(cm50)
title('Recording 50cm, fs=48kHz')
