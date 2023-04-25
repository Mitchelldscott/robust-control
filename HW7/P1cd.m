% F-16 lateral regulator
% JSH 3/9/20
clear all global;

% Plant dynamics
A =[-0.322 0.0640 0.0364 -0.9917 0.0003 0.0008 0;       % x1 = beta
    0 0 1 0.0037 0 0 0;                                 % x2 = phi
    -30.6492 0 -3.6784 0.6646 -0.7333 0.1315 0;         % x3 = p
    8.5396 0 -0.0254 -0.4764 -0.0319 -0.0620 0;         % x4 = r
    0 0 0 0 -20.2 0 0;                                  % x5 = delta_a
    0 0 0 0 0 -20.2 0;                                  % x6 = delta_r
    0 0 0 57.2958 0 0 -1];                              % x7 = x_w

B = [0 0; 
    0 0; 
    0 0; 
    0 0; 
    20.2 0; 
    0 20.2; 
    0 0];          % u1 = delta_a (aileron)
                   % u2 = delta_r (rudder)
C = [0 0 0 57.2958 0 0 -1;                              % y1 = r_w (washed out yaw rate)
    0 0 57.2958 0 0 0 0;                                % y2 = p
    57.2958 0 0 0 0 0 0;                                % y3 = beta
    0 57.2958 0 0 0 0 0];                               % y4 = phi
   
D = zeros(4,2);

% Static feedback controller u = -Ky
K = [-0.56 -0.44 -0.11 -0.35; 
    -1.19 -0.21 -0.44 0.26];

G = minreal(ss(A, B, C, D));
L = G * K;
So = (eye(4) + L)^-1;
To = L * So;

s = tf('s');
A = 4;
M = 10;
wb = 3;
tau = 0.02;
r0 = 0.05;
rinf = 0.4;
Wo = eye(4) * ((tau * s) + r0) / ((tau * s / rinf) + 1);
Wp = eye(4) * ((s/M) + wb) / (s + (wb*A));

% Nominal Performance
Nominal_Performance = norm(Wp * To, 'inf')

%  Robust Stability
Robust_Stability = norm(Wo * So, 'inf')