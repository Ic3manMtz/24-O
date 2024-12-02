# Load the data from hop02.txt
NR == 1 {
  # Skip header row
  next
}

# Process rows 200-299
NR >= 200 && NR <= 299 {
  # Calculate sampleRTT
  sampleRTT = $1
  
  # Calculate EstimatedRTT (assuming it's the average of last 3 samples)
  prev_sampleRTT = ($1 + $2 + $3) / 3
  EstimatedRTT = prev_sampleRTT
  
  # Calculate TimeoutInterval (assuming it's 4 times EstimatedRTT)
  TimeoutInterval = EstimatedRTT * 4
  
  # Print to separate files
  printf "%.2f\n", sampleRTT > "sampleRTT.txt"
  printf "%.2f\n", EstimatedRTT > "EstimatedRTT.txt"
  printf "%.2f\n", TimeoutInterval > "TimeoutInterval.txt"
}
