clear all;
close all;
clc;

load('D:\Dokumenty\Skola\VS\Diplomová práce\EEG Data\P81_egermaier\header.mat');
load('D:\Dokumenty\Skola\VS\Diplomová práce\EEG Data\P81_egermaier\EEG\ALL_P81_qEEG.mat', 'SEG_AVR');
d = SEG_AVR{3}(:,:,3); %3 Klastr
fs = 512;
header.nsample = size(d,1);
header.time = 0:1/fs:header.nsample/fs-1/fs;
tabs = header.time;
header.rate = fs;

figure();
plot(header.time,  SEG_AVR{3}(:,:,3));
grid on;
xlabel('t [s]');
ylabel('amplituda [V]');
title('Pacient P81, 3. cluster');