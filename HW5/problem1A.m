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