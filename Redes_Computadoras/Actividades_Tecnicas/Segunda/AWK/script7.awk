{
	suma += $3+$4
	count++
}
END{
	if(count > 0){
		print "El promedio de la suma de la columna 3 más la columna 4 es:", suma/count
	}else{
		print "El promedio de la suma de la columna 3 más la columna 4 es:", suma
	}
}
