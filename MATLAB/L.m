clear all
L_t = 1.1*(10^-3);
w = logspace(-5,5);
s = tf('s');
num = 1;
den = s*L_t;
 
H = num/den;
bode(H,w);