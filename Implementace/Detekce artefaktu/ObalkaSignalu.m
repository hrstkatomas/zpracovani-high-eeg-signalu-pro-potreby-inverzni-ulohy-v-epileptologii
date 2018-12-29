function eeg = ObalkaSignalu(eeg)
maxPuvodni = max(eeg);
eeg = eeg.^2;
b=1; a=[1 -0.995];
eeg = filtfilt(b,a,eeg);

konst = max (eeg)/maxPuvodni;
eeg = eeg/konst;
end