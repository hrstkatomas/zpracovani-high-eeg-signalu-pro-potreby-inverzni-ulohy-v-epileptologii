function [num, den] = Notch(fs, f, B)
%fs - vzorkovaci frekvence
%f - nepropustna frekvence
%B - pásmo

%Nula potlacujici zvolenou frekvenci lezi na jednotkove kruznici, na uhlu
%theta
the = 2*pi*f/fs; 
%Sire nepropustneho pasma je ovlivnena polohou polu filtru, cim blize bude
%pol k nule, tim mensi bude sire nepropustneho pasma. Vzdalenost od stredu
%jednotkove kruznice udava parametr r.
r = exp(-pi*2*B/fs);
% uhel prvni nuly/polu
e = exp(1i*the);
% druha nula/pol musi byt komplexne sdruzena
e2 = exp(1i*-the);

%nuly
num1 = [1, -e];
num2 = [1, -e2];
num = conv(num1, num2);

%poly
den1 = [1, -r*e];
den2 = [1, -r*e2];
den = conv(den1, den2);
end