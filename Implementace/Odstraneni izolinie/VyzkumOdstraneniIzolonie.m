clear all;
close all;
clc;

% Odstraneni izolinie se provadi filtrem Dolni propusti 0,5 Hz, 
% ze ketereho ziskam prubeh izolinie a odectu ho od puvodnich dat
% Pri vzorkovaci frekvenci 2042 Hz ale neni lehle navrhnout tak
% nizkou dolni propust, tudiz musim signal zdecimovat 2x, tak abych 
% dodrzel pravidlo o maximalni decimaci a nove ziskany signal dale
% interpolovat
% 

%Decimace:
% 1. decimaèní (=antialiasing) filtr pro omezení šíøky pásma
% 2. decimátor - vybírá (ponechává) každý M-tý vzorek - znaèení
% Mezní kmitoèet antialiasing filtru (dolní propusti) : fc < fs/2M, kde M je
%   decimacni cinitel
% 
%Interpolace
% 1. expandér - vložení L ? 1 nul mezi vzorky ? vznik zrcadel ve spektru
% 2. interpolaèní (anti-imaging) filtr pro odstranìní zrcadel - dolni propust
% Mezní kmitoèet filtru (dolní propusti): fc < fsnew / 2L


load('D:\Dokumenty\Skola\VS\Diplomová práce\EEG Data\P84\EEG\P84_2015-06-21_10-00_001.mat');

eeg = d(:,1); % pouze prvni kanal

% Puvodni
ha(1) = subplot(411);
t = 0:1/fs:(length(eeg)-1)/fs; % generovani casove osy
plot(t, eeg);
title('Pùvodní signál')
xlabel('t [s]');
ylabel('U [uV]');
grid on;
%%
% Decimovane
M = 10;
decimEeg = decimate(eeg, M, 'fir');
fsNew = fs/M;
decimEeg = decimate(decimEeg, M, 'fir');
fsNew = fsNew/M;

ha(2) = subplot(412);
t2 = 0:1/fsNew:(length(decimEeg)-1)/fsNew; % generovani casove osy
plot(t2, decimEeg);
xlabel('t [s]');
ylabel('U [uV]');
title('Decimace faktorem 100')
grid on;



%% Profiltrovane
f = [ 0.35 , 0.65]; % prechodove pasmo
m = [1, 0]; % definice propusti 
dev = [10^(-40/20), 1-10^(-1/20)];% potlaceni v 0dB a -40dB v jednotlivych usecich
[n, Wn, beta, ftype] = kaiserord(f, m, dev, fsNew);
b = fir1 (n, Wn, ftype, kaiser(n+1, beta));

FilterEeg = filtfilt(b,1, decimEeg);
t2 = 0:1/fsNew:(length(FilterEeg)-1)/fsNew; % generovani casove osy





%% Izolonie interpolace
Izolinie=interp(FilterEeg,M*M);
ha(3) = subplot(413);
t3 = 0:1/fs:(length(Izolinie)-1)/fs; % generovani casove osy
plot(t3, Izolinie);
xlabel('t [s]');
ylabel('U [uV]');
title('Odhad driftu')
grid on;
%% Vysledne
VysledneEeg=eeg-Izolinie(1:length(eeg));
ha(4) = subplot(414);
plot(t, VysledneEeg);
title('Odeètení izolinie od pùvodního signálu')
xlabel('t [s]');
ylabel('U [uV]');
grid on;

linkaxes(ha, 'x');

%% Navrh filtru
% clear all;
% close all;
% clc;
% 
% f = [ 0.35 , 0.65]; % prechodove pasmo
% m = [1, 0]; % definice propusti 
% dev = [10^(-40/20), 1-10^(-1/20)];% potlaceni v 0dB a -40dB v jednotlivych usecich
% [n, Wn, beta, ftype] = kaiserord(f, m, dev, fsNew);
% b = fir1 (n, Wn, ftype, kaiser(n+1, beta));

figure(2);
[H1, f] = freqz(b, 1, [], fsNew);

Ha1 = 20*log10(abs(H1));
plot(f, Ha1);

title('Frekvenèní charakteristika dolní propusti 0.5 Hz')
xlabel('f [Hz]');
ylabel('A [dB]');
xlim([0, fsNew/2]);
grid on;
