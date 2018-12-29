fs = 2048; % vzorkovaci f
f = 50; % potlacena f
B = 1; % sire nepropustneho pasma

% ziskani koeficientu
[b,a]=Notch(fs,f,B);

%Vykresleni
[H1, f1] = freqz (b, a, [], fs);
H1 = 20*log10(abs(H1));
plot(f1, H1);

% rozsireni nepropustneho pasma -> oddaleni polu od nuly
[b1,a1]=Notch(fs,f,B+20);

%Vykresleni cervene
[H2, f2] = freqz (b1, a1, [], fs);
H2 = 20*log10(abs(H2));
hold on
plot(f2, H2, 'red');
grid on
xlim([0 100]);
%%  Vykresleni nul a polu NOTCH filtru
figure()
zplane(b,a)
hold on
zplane(b1,a1)

%% Ukazka filtrace
% Priprava signalu
load('D:\Dokumenty\Skola\VS\Diplomová práce\EEG Data\SEPy\P110\EEG\P110_2016-03-22_14-46_051.mat');
y = d(:, 111)';
Fs = 2048;                    % Sampling frequency
T = 1/Fs;                     % Sample time
L = length(y);                     % Length of signal
t = (0:L-1)*T;                % Time vector

% Vypocet spektra
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot Spektra
figure()
subplot(211);
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Amplitudové spektrum elektrody L5G pacienta P110')
xlabel('f [Hz]')
xlim([45, 55]);
ylim([0,30]);
ylabel('|Y(f)|')
grid on

% Filtrace a vypocet filtrovaneho spektra
y = filtfilt(b,a,y);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot druheho spektra
subplot(212)
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Po aplikaci notch filtru')
xlabel('f [Hz]')
xlim([45, 55]);
ylim([0,30]);
ylabel('|Y(f)|')
grid on