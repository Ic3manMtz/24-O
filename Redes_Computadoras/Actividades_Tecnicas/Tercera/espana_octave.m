load espana_RTT.dat;
plot(espana_RTT, '--*', 'Color', 'r', 'LineWidth', 0.5, 'MarkerSize', 8);
grid on;
xlabel ('Vuelta de transmision');
ylabel ('Ping [ms]');
title('Ping https://universidadeuropea.com/');
print -dpng "trazaEspana.png";
