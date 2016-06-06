

# creates summary data table from cctrips 

summ_fun <- function (x) {cbind(freq = table(x), percentage = 
                                    round(prop.table(table(x)),4)*100, 
                                mode = as.numeric(row.names(table(x))))}

    

