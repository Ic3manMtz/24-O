data = load('output6.txt');
x = data(:, 1);
y = data(:, 2);
plot (x,y, '--', 'Color', 'k');
xlabel ('Tiempo de sesion');
ylabel ('Retardo de extremo a extremo');
title ('Grafica a gran escala Traza 6');
print -dpng "../../Reporte/img/traza6_GE.png";