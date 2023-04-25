u0 = 0.4 * 1126;
Yr = 0;
Nr = -0.639;
Nbeta = ureal('Nbeta', 15.16, 'percentage', 30);
Ybeta = ureal('Ybeta',-110.94, 'Percentage', 20);
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

CL_sys = lft(P, K);
[N, Delta, BlkStruct] = lftdata(CL_sys);
szDelta = size(Delta);
N11 = N(1:szDelta(2),1:szDelta(1));
freq = logspace(-1,1);
N11_frd = frd(N11,freq);
[mubnds] = mussv(N11_frd,BlkStruct);

% plot Stability Bounds
figure; clf;
h = sigmaplot(mubnds(1,1), 'bo', mubnds(1,2), 'r-');
setoptions(h,'MagUnits','abs', 'XLim', [1e-1,1e1]);
title("Stability bounds of Mu")
% 
N_frd = frd(N,freq);
clear BlkStruct; BlkStruct = [-1 0; -1 0; 2 2];
[mu_N] = mussv(N_frd,BlkStruct);

% plot Performance
figure; clf;
h = sigmaplot(mu_N(1,1), 'bo', mu_N(1,2), 'r-');
setoptions(h,'MagUnits','abs', 'XLim', [1e-1,1e1]);
title("Performace Mu plot")