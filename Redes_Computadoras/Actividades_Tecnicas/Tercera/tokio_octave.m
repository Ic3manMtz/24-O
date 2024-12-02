load tokio_RTT.dat;
plot(tokio_RTT, '--*', 'Color', 'r', 'LineWidth', 0.5, 'MarkerSize', 8);
grid on;
xlabel('Vuelta de transmision');
ylabel('Ping [ms]');
title('Ping 133.11.11.11');
print -dpng "trazaTokio.png";
