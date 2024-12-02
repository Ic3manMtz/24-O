load uam_RTT.dat;
plot(uam_RTT, '--*', 'Color', 'k', 'LineWidth', 0.5, 'MarkerSize', 8);
grid on;
xlabel ('Vuelta de transmision');
ylabel ('Ping [ms]');
title('Ping http://www.iztapalapa.uam.mx/');
print -dpng "trazaUam.png";
