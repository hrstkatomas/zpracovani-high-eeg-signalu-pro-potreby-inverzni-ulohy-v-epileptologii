clear all;
close all;
clc;

% Artefakty maji vyssi vykon, je potreba vyloucit je z analyzi
% dolnni propust z prubehu^2  cca odpovida odhadu vykonu z prubehu^2
% 1. Nacteni hodnot
% 2. Horni propust odfiltruje EEG - rekneme ze mozkovou aktivitu ocekavam
%    do 75 Hz, svalovou aktivitu ve vyssich radech
% 3. Odhad vykonu jako signal^2 a profiltruju DP
% 4. rozhodovaci hranice = 5 * median signalu
% 5. vylouceni z 

% 1. krok - nacteni dat
load('D:\Dokumenty\Skola\VS\Diplomová práce\hdeeg\P84\hdeegmat\P84_2015-06-21_11-10_008.mat')

%% zobrazeni dat
eeg = d(:,71); % pouze prvni kanal
t = 0:1/fs:(length(tabs)-1)/fs; % generovani casove osy
plot(t, eeg);
xlabel('t[s]');
grid on;
%% Potlaceni izolinie? - nevim jestli nezkresli signal

%%
% 2. krok - Horni propust
f = [ 75 , 100]; %Rozsahy prechodu filtru
m = [0, 1]; % toto definuje neprve potlacuj, pote propoustej
dev = [ 1-10^(-1/20), 10^(-40/20)]; % Pozadovane potlaceni z decibelu
[n, Wn, beta, ftype] = kaiserord(f, m, dev, fs);
b = fir1 (n, Wn, ftype, kaiser(n+1, beta));

% Zobrazeni charakteristiky filtru
% [H1, f] = freqz(b, 1, [], fs);
% Ha1 = 20*log10(abs(H1));
% plot(f, Ha1);

eeg2 = filter(b,1, eeg); % PRofiltrovano HP
%plot(eeg2);

% 3. krok - signal nadruhou a filtrace DP
eeg2 = eeg2.^2;
%plot(eeg2);

%Dolni propust
f2 = [0 ,20];
m2 = [1, 0];
dev2 = [ 1-10^(-1/20), 10^(-40/20)];
[n2, Wn2, beta2, ftype2] = kaiserord(f2, m2, dev2, fs);
b2 = fir1 (n2, Wn2, ftype2, kaiser(n2+1, beta2));
eeg2 = filter(b2,1, eeg2); % PRofiltrovano HP
%plot(eeg2);

% 4. krok - Rozhodovaci hranice
med = median(eeg2);
%med = med*5;

artefakty = eeg2 > med;
artefakty = artefakty .* eeg;
artefakty(artefakty == 0) = NaN;
%plot(t, eeg);
hold on
plot(t, artefakty, 'red');

