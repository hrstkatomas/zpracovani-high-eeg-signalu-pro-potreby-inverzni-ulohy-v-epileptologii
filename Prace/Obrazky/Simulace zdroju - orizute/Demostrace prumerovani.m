t = 0:0.01:10-0.01;
y = sin(t);
figure();
subplot(311)
plot(y)

prumeru = 500;
y = ones(prumeru,1)*y;

y1 = wgn(prumeru,1000,5);
y1 = y1 + y;
subplot(312)
plot(y1)

y2 = mean(y1, 1);

subplot(313)
plot(y2)
