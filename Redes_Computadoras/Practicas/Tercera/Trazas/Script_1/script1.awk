# Una frase terminal cuando se encuentra un periodo de silencio. Por lo tanto
# podemos contar los periodos de silencio como separadores de frases
BEGIN{
  talkspurts = 1
  input_file = ARGV[1]
  gsub("../", "", input_file)
}

$1 == "!" { 
  talkspurts++
}

END{
  print "Archivo de entrada:", input_file
  print "Numero total de frases:", talkspurts
  print ""
}
