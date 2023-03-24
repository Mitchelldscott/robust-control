% x_dot = Ax + Bu
% X = [P; phi, del_a] (roll rate, roll, aileron deflection)
% u = voltage
tau = 0.1;
Lp = -1;
Lda = 30;

A = [Lp 0 Lda;
	1 0 0;
	0 0 -1/tau];

B = [0; 0; 1/tau];

C = [0 1 0];

D = [0];


