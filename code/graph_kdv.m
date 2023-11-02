clc;
clear all;

x1 = -20:0.001000005:20;
x1 = x1';
t = -1+zeros(40000,1); % Change the time accordingly

y1 = u(t, x1);
 plot(x1, y1)
% plot(x1, y1 )
title('t = -1 sec') % Change the title accordingly
xlabel('x')
ylabel('u(t,x)')
grid on
function output = u(t,x)
    output=12*(3+4*cosh(2*x-8*t)+cosh(4*x-64*t))./(3*cosh(x-28*t)+cosh(3*x-36*t)).^2;

end