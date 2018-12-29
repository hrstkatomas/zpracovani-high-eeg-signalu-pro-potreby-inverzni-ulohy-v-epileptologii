% clear all;
% close all;
% clc;


load('D:\Dokumenty\Skola\VS\Diplomová práce\EEG Data\SEPy\P110\EEG\P110_2016-03-22_14-36_049.mat')

amp1 = 1:128;
amp2 = 129:256;
%%
d = amplifierCorrection(d, amp1, amp2);