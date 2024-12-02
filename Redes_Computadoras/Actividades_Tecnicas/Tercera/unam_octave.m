load unam_RTT.dat;
plot(unam_RTT, '--*', 'Color', 'k', 'LineWidth', 0.5, 'MarkerSize', 8);
grid on;
xlabel('Vuelta de transmision');
ylabel('Ping [ms]');
title('Ping www.unam.mx');
print -dpng "trazaUnam.png";

