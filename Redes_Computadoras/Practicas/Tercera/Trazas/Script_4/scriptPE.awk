# Este script genera un archivo con dos columnas: tiempo de la sesión y retardo extremo a extremo.
BEGIN{
    #Llama al script que se encarga de obtener la diferencia minima
    temp_file = "output.tmp"
    input_file = ARGV[1]
    command = "awk -f ../Script_3/script3.awk "input_file " > " temp_file
    system(command)

    # Procesa la salida del archivo temporal
    while ((getline line < temp_file) > 0) {
        # Procesa cada línea de salida del segundo script
        if (line ~ /Diferencia minima:/) {
            split(line, fields, ":")
            tmin = fields[2]
        }
    }

    # Limpia el archivo temporal
    system("rm -f " temp_file)

    t1_flag = 0
    talkspurts = 1
}

$1 == "D"{
   # if ($2-$3 < tmin) {
    #    tmin = $2-$3
    #}

    if (t1_flag == 0){
        t1 = $3
        t1_flag = 1
    }

    session_time = ($3 - t1) / 8000
    end_to_end_delay = ($2 - $3 - tmin) / 8000
    print session_time, end_to_end_delay
}


$1 == "!"{
  talkspurts++ # Incrementa el contador al encontrar un espacio de silencio
  if(talkspurts == 11){
    exit # Termina la ejecucion si encuentra cuatro signos "!"
  }
}
