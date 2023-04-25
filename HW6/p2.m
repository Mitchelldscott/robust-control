s = tf('s');
a = (s+1);
b = (s+2);
c = (s+3);
G = [2/a 1/(a*b);
     1/(a*b) 2/b];

K = [2/b 0;
     0 1/c];

L = K * G;
S = 1 / (eye(2) + L);
T = L * S;

figure
h = sigmaplot(S);
setoptions(h,'MagUnits','abs');
legend()

figure
h = sigmaplot(T);
setoptions(h,'MagUnits','abs');
legend()

figure
h = sigmaplot(G);
setoptions(h,'MagUnits','abs');
legend()