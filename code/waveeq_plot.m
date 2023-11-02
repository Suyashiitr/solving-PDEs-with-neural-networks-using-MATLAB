clc
% % 𝑢(𝑡,𝑥)=sin(𝜋𝑥)cos(𝜋𝑡)/2 + sin(3𝜋𝑥)sin(3𝜋𝑡)/3
x1 = 0.000025:0.000025:1;
y1 = u(0.25,x1);
plot(x1,y1)
title('t= 0.25 sec')
xlabel('x in m')
ylabel('u in m/s')
function output = u(t,x)
    output = sin(x*pi).*cos(pi*t)/2 + sin(3*pi*x).*sin(3*pi*t)/3 ;
end