# Este script encuentra la diferencia mínima entre la estampa del receptor y la del emisor.
BEGIN{
    min_diff = "Inf"
    input_file = ARGV[1]
    gsub("../", "", input_file)
}

$1 == "D"{  # Solo se calcula la diferencia cuando hay un paquete recibido
    diff = $2 - $3 # Ya que solo es la diferencia no se toma encuenta que el numero que se obtiene puede ser negativo
    if (diff < min_diff){
        min_diff = diff
    }
}

END{
    print "Archivo de entrada:", input_file
    print "Diferencia minima:", min_diff   
    print ""
}
