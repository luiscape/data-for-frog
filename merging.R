# Creating a source list.
source_list <- c('fts', 'rw', 'sw')

# Adding a row to the dataset to make them the same structure.
# For ReliefWeb.
# temp <- read.csv('data/rw-value.csv')
# temp$source <- "ReliefWeb"
# write.csv(temp, 'data/rw-value.csv', row.names = F)

# Creating empty data.frames.
final_dataset <- data.frame()
final_indicator <- data.frame()
final_value <- data.frame()

# Fetching and merging all data.
for (i in 1:length(source_list)) { 
    src <- source_list[i]
    x  <- read.csv(paste0('source-data/', src, '-', 'dataset.csv'))
    y  <- read.csv(paste0('source-data/', src, '-', 'indicator.csv'))
    z  <- read.csv(paste0('source-data/', src, '-', 'value.csv'))  
    
    if (i == 1) { 
        final_dataset <<- x
        final_indicator <<- y
        final_value <<- z
    }
    
    else { 
        final_dataset <<- rbind(final_dataset, x)
        final_indicator <<- rbind(final_indicator, y)
        final_value <<- rbind(final_value, z)
    }
}

# Writing CSV files. 
write.csv(final_dataset, 'frog-data/dataset.csv', row.names = F)
write.csv(final_indicator, 'frog-data/indicator.csv', row.names = F)
write.csv(final_value, 'frog-data/value.csv', row.names = F)


# Storing data in a database.
library(sqldf)

db <- dbConnect(SQLite(), dbname="frog-data/db.sqlite")

    dbWriteTable(db, "dataset", final_dataset, row.names = FALSE, overwrite = TRUE)
    dbWriteTable(db, "indicator", final_indicator, row.names = FALSE, overwrite = TRUE)
    dbWriteTable(db, "value", final_value, row.names = FALSE, overwrite = TRUE)
    
    # for testing purposes
    # test <- dbReadTable(db, "value")

dbDisconnect(db)
