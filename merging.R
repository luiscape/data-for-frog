# Creating a source list.
source_list <- c('fts', 'rw', 'sw')

# Attention: Data from ReliefWeb needs calibration. 
# It shall be updated in the current week. 

# Adding a row to the dataset to make them the same structure.
# For ReliefWeb.
# temp <- read.csv('data/rw-value.csv')
# temp$source <- "ReliefWeb"
# write.csv(temp, 'data/rw-value.csv', row.names = F)


# FTS API source: http://fts.unocha.org/api/Files/APIUserdocumentation.htm

# Loading the current  CHD list.
source('load_chd_list.R')

# Creating empty data.frames.
final_dataset <- data.frame()
final_indicator <- data.frame()
final_value <- data.frame()

# Fetching and merging all data.
for (i in 1:length(source_list)) { 
    src <- source_list[i]
    x  <- read.csv(paste0('source_data/', src, '-', 'dataset.csv'))
    y  <- read.csv(paste0('source_data/', src, '-', 'indicator.csv'))
    z  <- read.csv(paste0('source_data/', src, '-', 'value.csv'))  
    
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

final_value_all <- final_value

# Subsetting for the focus countries. 
focus_countries <- as.list(c('YEM', 'KEN', 'COL'))
final_value <- subset(final_value, final_value$region == focus_countries)

# Writing CSV files. 
write.csv(final_dataset, 'frog_data/dataset.csv', row.names = F)
write.csv(final_indicator, 'frog_data/indicator.csv', row.names = F)
write.csv(final_value, 'frog_data/value.csv', row.names = F)

# Values for ALL countries.
write.csv(final_value_all, 'frog_data/value_all.csv', row.names = F)


# Storing data in a database.
library(sqldf)

db <- dbConnect(SQLite(), dbname="frog-data/db.sqlite")

    dbWriteTable(db, "dataset", final_dataset, row.names = FALSE, overwrite = TRUE)
    dbWriteTable(db, "indicator", final_indicator, row.names = FALSE, overwrite = TRUE)
    dbWriteTable(db, "value", final_value, row.names = FALSE, overwrite = TRUE)
    dbWriteTable(db, "value_all", final_value_all, row.names = FALSE, overwrite = TRUE)
    
    # for testing
    # test <- dbReadTable(db, "value")

dbDisconnect(db)