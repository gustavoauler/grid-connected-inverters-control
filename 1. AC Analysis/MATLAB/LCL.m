clear all
L_t = 1.1*(10^-3);
L_g = 99.94*(10^-6);
R_f = 2.51;
C_f = 57.54*(10^-6);
s = tf('s');
num = s*R_f*C_f + 1;
den = (s^3)*C_f*L_g*L_t + (s^2)*R_f*C_f*(L_g + L_t) + s*(L_g + L_t);

H = num/den;
% G = bodeplot(H,w);
w = logspace(-5,5);
 bode(H)
% nyquist(H)
% setoptions(G,'FreqUnits','Hz')
% sisotool(H)