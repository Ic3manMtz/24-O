load alemania_RTT.dat;
plot(alemania_RTT, '--*', 'Color', 'b', 'LineWidth', 0.5, 'MarkerSize', 8);
grid on;
xlabel('Vuelta de transmision');
ylabel('Ping [ms]');
title('Ping 130.149.17.21');
print -dpng "trazaAlemania.png";
