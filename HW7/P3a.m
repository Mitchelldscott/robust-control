u0 = 0.4 * 1126;
Yr = 0;
Nr = -0.639;
Nbeta = 15.16;
Ybeta = -110.94;
Ndela = 0.334;
Ydelr = 19.65;
Ndelr = -6.732;

A = [(Ybeta/u0) -(1-(Yr/u0)); Nbeta Nr];
B = [0 Ydelr/u0; Ndela Ndelr];
C = eye(2);
D = 0;

G = ss(A,B,C,D);

M = 2;
A = 0.005;
wb = 1;
Wp = eye(2) * ((s/M)+wb) / (s+(wb*A));

systemnames = 'G Wp';
inputvar = '[w(2); u(2)]';
outputvar = '[Wp; -G-w]';
input_to_G = '[u]';
input_to_Wp = '[G+w]';
sysoutname = 'P';
sysic;

[K,CL,GAM,info] = hinfsyn(minreal(ss(P)), 2, 2, 'method', 'ric', 'Tolgam', 1e-3, 'DISPLAY', 'on');
L = minreal(G * K);
So = (eye(2)+L)^-1;
To = L * So;

figure
hold on
h = sigmaplot(inv(Wp), 'r--', So, 'b-');
setoptions(h,'MagUnits','abs', 'XLim', [1e-1,1e1]);
legend("1/Wp", "So")
title("Nominal Performance")