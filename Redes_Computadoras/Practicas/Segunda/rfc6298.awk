BEGIN {
    # Inicialización de parámetros
    alpha = 1/8    # Suavizado para SRTT
    beta = 1/4     # Suavizado para RTTVAR
    K = 4          # Factor para RTTVAR
    G = 1          # Valor mínimo para RTTVAR
    RTO = 1        # Valor inicial de RTO
    firstRTT = 1   # Bandera para la primera medición RTT
    sample_count = 0  # Contador de muestras procesadas
    start_sample = 200  # Comenzar a partir de la muestra 200
    max_samples = 30     # Tomar solo 30 muestras
}

{
    # Incrementar el contador de muestras
    sample_count++

    # Solo procesar muestras a partir de la muestra 200
    if (sample_count >= start_sample && sample_count < start_sample + max_samples) {
        # RTT_value es el único valor por línea
        RTT = $1

        # Primer RTT
        if (firstRTT == 1) {
            SRTT = RTT
            RTTVAR = RTT / 2
            RTO = SRTT + (K * RTTVAR > G ? K * RTTVAR : G)
            firstRTT = 0
        } else {
            # RTT subsecuentes
            RTTVAR = (1 - beta) * RTTVAR + beta * (SRTT > RTT ? SRTT - RTT : RTT - SRTT)
            SRTT = (1 - alpha) * SRTT + alpha * RTT
            RTO = SRTT + (K * RTTVAR > G ? K * RTTVAR : G)
        }

        # Escribir en los archivos de salida
        print RTT >> "sampleRTT"
        print SRTT >> "estimatedRTT"
        print RTO >> "timeoutInterval"
    }

    # Si ya se procesaron 30 muestras, terminamos el script
    if (sample_count >= start_sample + max_samples) {
        exit
    }
}

END {
    print "Proceso completado. Los archivos de salida son: sampleRTT, EstimatedRTT, TimeoutInterval."
}
