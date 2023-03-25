figure
sigma(inv(W1), 'r--', So, 'b', So2, 'g', {10^-2, 10^3});
legend('1 / W1', 'So', 'So2')

figure
sigma(inv(W2), 'r--', K*So, 'b', K2*So2, 'g');
legend('1 / W2', 'Kso', 'K2So2')

figure
grid on
step(To, 'b', To2, 'g')
legend('H_{\infty}', 'H_2')