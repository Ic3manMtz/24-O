set ns [new Simulator]

#Definir diferentes colores para los flujos de datos (en NAM)
$ns color 1 Blue
$ns color 2 Red

# Abrir los archivos de traza
set file1 [open out.tr w]
set winfile [open WinFile w]
$ns trace-all $file1

# Abrir el archivo de traza de NAM
set file2 [open out.nam w]
$ns namtrace-all $file2

#Definir un procedimiento ’finish’
proc finish {} {
  global ns file1 file2
  $ns flush-trace
  close $file1
  close $file2
  exec nam out.nam &
  exit 0
}

# Crear seis nodos
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

# Crear los enlaces entre los nodos
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns simplex-link $n2 $n3 0.3Mb 100ms DropTail
$ns simplex-link $n3 $n2 0.3Mb 100ms DropTail
$ns duplex-link $n3 $n4 0.5Mb 40ms DropTail
$ns duplex-link $n3 $n5 0.5Mb 30ms DropTail

# Posicionar los nodos (para NAM)
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns simplex-link-op $n2 $n3 orient right
$ns simplex-link-op $n3 $n2 orient left
$ns duplex-link-op $n3 $n4 orient right-up
$ns duplex-link-op $n3 $n5 orient right-down

#Set Queue Size of link (n2-n3) to 10
$ns queue-limit $n2 $n3 20

# Configurar una conexión TCP
set tcp [new Agent/TCP/Newreno]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink/DelAck]
$ns attach-agent $n4 $sink
$ns connect $tcp $sink
$tcp set fid_ 1
$tcp set window_ 8000
$tcp set packetSize_ 552

# Configurar una aplicación FTP sobre la conexión TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

# Configurar un flujo UDP
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n5 $null
$ns connect $udp $null
$udp set fid_ 2

# Configurar una fuente de tráfico CBR sobre el flujo UDP
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000
$cbr set rate_ 0.01mb
$cbr set random_ false
$ns at 0.1 "$cbr start"
$ns at 1.0 "$ftp start"
$ns at 124.0 "$ftp stop"
$ns at 124.5 "$cbr stop"

# El siguiente procedimiento recibe dos argumentos:
# el nombre del nodo fuente TCP ("tcp") y el nombre
# del archivo de salida
proc plotWindow {tcpSource file} {
  global ns
  set time 0.1
  set now [$ns now]
  set cwnd [$tcpSource set cwnd_]
  set wnd [$tcpSource set window_]
  puts $file "$now $cwnd"
  $ns at [expr $now+$time] "plotWindow $tcpSource $file"
}

$ns at 0.1 "plotWindow $tcp $winfile"
$ns at 125.0 "finish"
$ns run