load australia_RTT.dat;
plot(australia_RTT, '--*', 'Color', 'b', 'LineWidth', 0.5, 'MarkerSize', 8);
grid on;
xlabel ('Vuelta de transmision');
ylabel ('Ping [ms]');
title('Ping https://sydney.edu.au/');
print -dpng "trazaAustralia.png";
