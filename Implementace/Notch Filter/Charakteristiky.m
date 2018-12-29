fs = 400; % vzorkovaci f
f = 50; % potlacena f
B = 20; % sire nepropustneho pasma

% ziskani koeficientu
[b,a]=Notch(fs,f,B);
[H1, f1] = freqz (b, a, [], fs);
H1 = 20*log10(abs(H1));


figure();
subplot (221);
plot(f1, H1);
grid on
title('Frekvenèní charakteristika');
xlabel('f [Hz]');
ylabel('A [dB]');
subplot (223)
zplane(b,a)
title('Diagram nul a pólù');
xlabel('Reálná èást');
ylabel('Imaginární èást');

% druhy filter
[b,a]=Notch(fs,f,2);
[H1, f1] = freqz (b, a, [], fs);
H1 = 20*log10(abs(H1));

subplot (222);
plot(f1, H1);
grid on
title('Frekvenèní charakteristika');
xlabel('f [Hz]');
ylabel('A [dB]');
subplot (224)
zplane(b,a)
title('Diagram nul a pólù');
xlabel('Reálná èást');
ylabel('Imaginární èást');