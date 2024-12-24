# Una frase 
BEGIN{
  talkspurts = 0
}

$1 == "!" { talkspurts++}

END{
  print "Numero total de frases:", talkspurts
}