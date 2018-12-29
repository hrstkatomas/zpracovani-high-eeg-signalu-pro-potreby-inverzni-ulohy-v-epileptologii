% clear all;
close all;
clc;

load('D:\Dokumenty\Skola\VS\Diplomová práce\EEG Data\P84\EEG\P84_2015-06-21_10-00_001.mat');

eeg = d(:,1:10); % pouze prvni kanal

% Puvodni
t = 0:1/fs:(length(eeg)-1)/fs; % generovani casove osy
ha(1) = subplot(211);
plot(t, eeg); title('Originalni signal'); xlabel('t[s]'); grid on;

% Nove
%%
tic
eeg2 = deleteDrift(eeg, fs);
toc
ha(2) = subplot(212);
plot(t, eeg2); title('Bez Izolonie'); xlabel('t[s]'); grid on;

linkaxes(ha, 'x');
