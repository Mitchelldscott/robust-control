tau = 0.1;
Lp = -1;
Ldelalpha = 30;

A = 0.1;
M = 10;
omega_b = 1.8 / 4;

s = tf('s');
W1 = ((s / M) + omega_b) / (s + (omega_b * A));
W2 = 100 * (s + 0.1) / (s + 100);

A = [Lp 0 Ldelalpha; 1 0 0; 0 0 -1/tau];
B = [0; 0; 1/tau];
C = [0 1 0];
D = 0;

G = ss(A, B, C, D);

sysnames = 'G W1 W2';
inputvar = '[w; u]';
outputvar = '[ W1; W2; w - G]';
input_to_G = '[u]';
input_to_W1 = '[w-G]';
input_to_W2 = '[u]';
sysoutname = 'P';

[Kinf, Pcl, gamma] = hinfsyn(P, 1, 1)

S0 = ;

sigmaplot(1 / W1);
sigmaplot(S0)
