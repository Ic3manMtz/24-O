data = load('output6_PE.txt');
x = data(:, 1);
y = data(:, 2);
stem (x,y, 'Color', 'k');
xlabel ('Tiempo de sesion');
ylabel ('Retardo de extremo a extremo');
title ('Grafica a pequeña escala Traza 6');
print -dpng "../../Reporte/img/traza6_PE.png";