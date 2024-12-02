{
	if(NR == 1 || $4<min){
		min = $4
	}

}
END{
	print "El valor minimo de la columna 4 es:", min
}
