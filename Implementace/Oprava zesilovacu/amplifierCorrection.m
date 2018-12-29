function Dout = amplifierCorrection(D, amp1, amp2)
% D - data matrix to be corrected [data x channels]
% amp1 - indexes of channels that belongs to first amplifier
% amp2 - indexes of channels that belongs to second amplifier
% 
% Dout - corrected data, 

% This method calculates mean from both apmlifiers and then subtractnig it from the data

mean1 = mean(D(:,amp1),2);
mean2 = mean(D(:,amp2),2);

Dout = D;

Dout(:,amp1) = Dout(:,amp1) - mean1 * ones(1,length(amp1));
Dout(:,amp2) = Dout(:,amp2) - mean2 * ones(1,length(amp2));
end