function d = ApplyNotch (d, fc, fs)
% Applies Notch filter that filters frequency fc 
% d - data matrix [Lenght of data x number of channels]
% fc - frequency to be filtered
% fs - sampling frequency of data matrix d
B = 2;
[b,a]=Notch(fs,fc,B);

for i = 1:size(d,2)
    y = d(:,i);
    y = y';
    
    y = filtfilt(b,a,y);
    d(:,i) = y';
end

end