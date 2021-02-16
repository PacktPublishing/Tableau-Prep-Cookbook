divide <- function(df) 
{ 
	TransactionAmount = df$TransactionAmount/2

	return(data.frame(
	TransactionAmount
   ))
}

multiply <- function(df) 
{ 
	TransactionAmount = df$TransactionAmount*2

	return(data.frame(
	TransactionAmount
   ))
}

getOutputSchema <- function() {      
  return (data.frame (
    TransactionAmount = prep_decimal ()));
}