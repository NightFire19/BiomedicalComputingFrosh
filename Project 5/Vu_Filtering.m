clear; close all; clc;
%Name: Khang Vu
%Project 5: Filtering
%Date submitted: 
%Date due: 5/13/2016
%Version 1.0

t=0:1/200:1;
x=2*sin(pi*6*t)+3*sin(pi*24*t)+5*sin(pi*180*t);

figure(1);
subplot(3,1,1);
plot(t,x);
xlabel('Time');
ylabel('Amps');

[a, b]=Vu_digfilt1(x);
subplot(3,1,2);
plot(1:b,a);

[c, d]=Vu_digfilt2(x);
subplot(3,1,3);
plot(1:d,c);
