# Crear un objeto simulator
set ns [new Simulator]

# Abrir el archivo de traza de NAM
set nf [open out.nam w]
$ns namtrace-all $nf

# Definir un procedimiento 'finish'
proc finish {} {
  global ns nf
  $ns flush-trace
  
  # Cerrar el archivo de traza
  close $nf

  # Ejecutar NAM sobre el archivo de traza
  exec nam out.nam &
  exit 0
}

# Crear dos nodos
set n0 [$ns node]
set n1 [$ns node]

# Crear un enlace duplex entre dos nodos
$ns duplex-link $n0 $n1 1Mb 10ms DropTail

# Crear un agente UDP y adjuntarlo al nodo n0
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

# Crear una fuente de tráfico CBR y adjuntarla a udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

# Crear un agente Null (un receptor de tráfico o ’sumidero’) y
# adjuntarlo al nodo n1
set null0 [new Agent/Null]
$ns attach-agent $n1 $null0

# Conectar la fuente de tráfico al sumidero
$ns connect $udp0 $null0

# Calendarizar los eventos de la fuente CBR
$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"

# Llamar al procedimiento ’finish’ después de 5 segundos de
# tiempo de simulación
$ns at 5.0 "finish"
# Ejecutar la simulación
$ns run