tau = 50;
s = tf('s');
l = tau*s + 1;
G = 1/l * [-87.8 1.4;
         -108.2 -1.4];
K = l/s * [-1.5e-3 0;
           0 -7.5e-2];

W1 = makeweight(0.1,50,2);
W2 = makeweight(0.05,75,2);

figure
h = sigmaplot(W1, W2);
setoptions(h,'MagUnits','abs');
legend("W1", "W2");

L = G*K;
S = 1 / (eye(2) + L);
T = L * S;
W = [W1 0; 0 W2];

figure 
h = sigmaplot(W * T);
setoptions(h,'MagUnits','abs');
legend("MOU")

figure 
h = sigmaplot(W * S);
setoptions(h,'MagUnits','abs');
legend("IMIU");