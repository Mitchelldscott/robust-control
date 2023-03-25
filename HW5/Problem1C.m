% x_dot = Ax + Bu
% X = [P; phi, del_a] (roll rate, roll, aileron deflection)
% u = voltage
tau = 0.1;
Lp = -1;
Lda = 30;

A = 0.0005;		   % low value for good tacking
M = 10;			   % higher value for good disturbance rejection
omega_b = 1.8 / 3; % 1.8 / rise time = omega

s = tf('s');
W1 = ((s / M) + omega_b) / (s + (omega_b * A));
W2 = 100 * (s + 0.1) / (s + 100);

A = [Lp 0 Lda;
	1 0 0;
	0 0 -1/tau];

B = [0; 0; 1/tau];

C = [0 1 0];

D = 0;

G = ss(A, B, C, D);

systemnames = 'G W1 W2';
inputvar = '[w; u]';
outputvar = '[ W1; W2; w - G]';
input_to_G = '[u]';
input_to_W1 = '[w-G]';
input_to_W2 = '[u]';
sysoutname = 'P';
sysic;
P = minreal(ss(P))

hinfnorm(W1)

n_meas = 1;
n_ctrl = 1;
[K,CL,GAM,info] = hinfsyn(P, n_meas, n_ctrl, 'method', 'ric', 'Tolgam', 1e-3, 'Display', 'on');
So = minreal(inv(eye(1) + (G * K)));
To = minreal(G * K / (eye(1) + (G * K)));

[K2,CL2,GAM2,info2] = h2syn(P, n_meas, n_ctrl);
So2 = minreal(inv(eye(1) + (G * K2)));
To2 = minreal(G * K2 / (eye(1) + (G * K2)));