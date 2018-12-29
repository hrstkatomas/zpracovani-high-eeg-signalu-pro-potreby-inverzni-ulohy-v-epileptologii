function eeg_out = KlouzavePrumery(eeg, n);


%citatel
    a = ones(n,1)'.*1/n;
%jmenovatel
    b = 1;
    
    eeg_out = filter(a,b,eeg);

end