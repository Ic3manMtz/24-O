# Este script genera un archivo con dos columnas: tiempo de la sesión y retardo extremo a extremo.
BEGIN{
    tmin = "Inf" # Inicializa con el valor infinito
}

$1 == "D"{
    if ($2 < tmin) {
        tmin = $2
    }
    session_time = ($2 - tmin) / 8000
    end_to_end_delay = ($2 - $3 - tmin) / 8000
    print session_time, end_to_end_delay
}