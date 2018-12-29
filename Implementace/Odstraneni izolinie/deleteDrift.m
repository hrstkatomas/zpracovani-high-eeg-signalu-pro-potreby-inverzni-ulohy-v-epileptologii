function eeg = deleteDrift(eeg, fs)
% deletes drift on the data by calculating drift in the data and
% substracting it
% eeg - data matrix [Lenght of data x number of channels]
% fs - sampling frequency of data matrix d
for i = 1:size(eeg,2) 
    eeg2 = eeg(:,i);
    % Decimovane
    M = 10;
    decimEeg = decimate(eeg2, M, 'fir');
    fsNew = fs/M;
    decimEeg = decimate(decimEeg, M, 'fir');
    fsNew = fsNew/M;

    % Profiltrovani DP cca 0,5 Hz
    f = [ 0.35 , 0.65]; % prechodove pasmo
    m = [1, 0]; % definice propusti 
    dev = [10^(-40/20), 1-10^(-1/20)];% potlaceni v 0dB a -40dB v jednotlivych usecich
    [n, Wn, beta, ftype] = kaiserord(f, m, dev, fsNew);
    b = fir1 (n, Wn, ftype, kaiser(n+1, beta));

    FilterEeg = filtfilt(b,1, decimEeg);

    % Izolonie interpolace
    Izolinie=interp(FilterEeg,M*M);

    % Vysledne
    eeg(:,i)=eeg(:,i)-Izolinie(1:length(eeg));
end
end