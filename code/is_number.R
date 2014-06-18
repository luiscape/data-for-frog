## Validation test for is_number ## 
is_number <- function(df = NULL) { 
    for (i in 1:nrow(df)) { 
        if (is.numeric(df$value) == TRUE) { df$is_number[i] <- as.integer(1) }
        else { df$is_number[i] <- as.integer(0) }
    }
    return(df)
}