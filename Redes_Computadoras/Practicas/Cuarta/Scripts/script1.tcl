#Crear un objeto simulator
set ns [new Simulator]

#Abrir el archivo de traza para NAM
set nf [open out.nam w]
$ns namtrace-all $nf

#Definir un procedimiento 'finish'
proc finish {} {
  global ns nf
  $ns flush-trace

  #Cerrar el archivo de traza
  close $nf

  #Ejecutar NAM sobre el archivo de traza
  exec nam out.nam &

  exit 0
}

#Llamar al procedimiento finish después de 5 segundos
#de tiempo de simulación
$ns at 5.0 "finish"

#Ejecutar la simulación
$ns run