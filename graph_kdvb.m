clc;
clear all;

x1 = -20:0.001000005:20;
x1 = x1';
t = 1 + zeros(40000,1); % Change the time accordingly
y1 = u(t, x1);
plot(x1, y1)
title('t = 1 sec') % Change the title accordingly
xlabel('x')
ylabel('u(t,x)')
function output = u(t,x)
   al=1;
   be=-0.0075;
   ga=pi/1000;
   r=(be/(10*ga))*(x+(6*be*be/(25*ga))*t);
   output = (-1*6*be/(25*ga))*(1+tanh(r)+0.5*(sech(r)).^2) ;
end