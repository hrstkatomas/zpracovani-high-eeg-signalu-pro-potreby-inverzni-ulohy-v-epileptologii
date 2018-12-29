clear all;
close all;
clc;

n = 20;
%citatel
    a = ones(n,1)'.*1/n;
%jmenovatel
    b = 1;

freqz (a, b, [], 2*pi);

figure();
zplane(a, b);
