# Script for creating CPS-like tables for forg + denormalized table.

# Creating empty data.frames.
final_dataset <- data.frame()
final_indicator <- data.frame()
final_value <- data.frame()

# # Adding URL to FTS data. 
# fts_data <- read.csv('source_data/fts-value.csv')
# fts_data$source <- 'http://fts.unocha.org/api/Files/APIUserdocumentation.htm'
# write.csv(fts_data, 'source_data/fts-value.csv', row.names = F) 

# Creating a source list.
source_list <- c('fts', 'rw', 'sw', 'op')

# Fetching and merging all data.
for (i in 1:length(source_list)) { 
    src <- source_list[i]
    a  <- read.csv(paste0('source_data/', src, '-', 'dataset.csv'))
    b  <- read.csv(paste0('source_data/', src, '-', 'indicator.csv'))
    c  <- read.csv(paste0('source_data/', src, '-', 'value.csv'))  
    if (i == 1) { 
        zDataset <- a
        zIndicator <- b
        zValue <- c
    }
    else { 
        zDataset <- rbind(zDataset, a)
        zIndicator <- rbind(zIndicator, b)
        zValue <- rbind(zValue, c)
    }
}

## Selecting only CHD data.
# Loading the current  CHD list.
source('code/load_chd_list.R')
indicator_list <- as.character(chd_list$indID)
zIndicator <- zIndicator[which(zIndicator$indID %in% indicator_list), ]
zIndicator$in_chd <- NULL


## Running validation tests. 
# The duplicates validation test is failing now due to the 
# fact that one dummy indicator being the same as another.
source('code/validation_tests.R')
runValidation(df = zValue)


# Writing CSV files. 
write.csv(zDataset, 'frog_data/csv/dataset.csv', row.names = F)
write.csv(zIndicator, 'frog_data/csv/indicator.csv', row.names = F)
write.csv(zValue, 'frog_data/csv/value.csv', row.names = F)

# Storing data in a database.
library(sqldf)

db <- dbConnect(SQLite(), dbname="frog_data/db/cps_model_db.sqlite")

    dbWriteTable(db, "dataset", zDataset, row.names = FALSE, overwrite = TRUE)
    dbWriteTable(db, "indicator", zIndicator, row.names = FALSE, overwrite = TRUE)
    dbWriteTable(db, "value", zValue, row.names = FALSE, overwrite = TRUE)
    
    # for testing
    # test <- dbReadTable(db, "value")

dbDisconnect(db)

## Creating a single flat table.
x_temp <- zIndicator
y_temp <- zDataset
colnames(x_temp)[2] <- "indicator_name"
colnames(y_temp)[4] <- "source_name"

denorm_data <- merge(zValue, x_temp, by = "indID")
denorm_data <- merge(denorm_data, y_temp, by = "dsID")

write.csv(zValue, 'frog_data/csv/value.csv', row.names = F)

# Storing in a single, flat table.
db <- dbConnect(SQLite(), dbname="frog_data/db/denormalized_db.sqlite")

    dbWriteTable(db, "dataset_denorm", denorm_data, row.names = FALSE, overwrite = TRUE)
    # for testing
#     test <- dbReadTable(db, "dataset_denorm")

dbDisconnect(db)
