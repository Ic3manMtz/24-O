# Este script calcula el retardo promedio extremo a extremo.
BEGIN{
    total_delay = 0; count = 0
    input_file = ARGV[1]
    gsub("../", "", input_file)
}

$1 == "D"{
    delay = ($2 - $3) / 8000
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