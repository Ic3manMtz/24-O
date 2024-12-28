# Este script calcula el retardo promedio extremo a extremo.
BEGIN{
    tmin = "Inf" # Inicializa con el valor infinito
    total_delay = 0
    input_file = ARGV[1]
    gsub("../", "", input_file)
}

$1 == "D"{

    if ($2-$3 < tmin) {
        tmin = $2-$3
    }
    
    delay = ($2 - $3 - tmin) / 8000
    total_delay += delay
    count++
}

END{
    print "Archivo de entrada:", input_file
    if (count > 0) {
        print "Retardo promedio extremo a extremo:", total_delay / count
    } else {
        print "No se encontraron datos para calcular el retardo promedio."
    }
    print ""
}

