# Cada paquete tiene una línea que comienza con "D".
BEGIN{
    paquetes = 0
    input_file = ARGV[1]
    gsub("../", "", input_file)
}

$1 == "D"{
    paquetes++
}

END{
    print "Archivo de entrada:", input_file
    print "Número total de paquetes recibidos:", paquetes
    print ""
}

