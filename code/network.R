## Transforming data for network analysis. ##

library(reshape2)

# creating ids for the source
dataset <- read.csv('frog_data/csv/dataset.csv')
dataset$group_id <- 1:nrow(dataset)

# the classification of each topic will be done based on the hierarchy
# of the CHD classification. 
indicator <- read.csv('frog_data/csv/indicator.csv')

# classifier
classifyIndicators <- function(df = NULL) {
    for(i in 1:nrow(df)) {
        if (grepl("CHD", indicator$indID[i], fixed = T) == TRUE) {
            df$level_0[i] <- 'global'
        }
        if (grepl(".O.", indicator$indID[i], fixed = T) == TRUE) {
            df$level_1[i] <- 'operational'
        }
        if (grepl(".B.", indicator$indID[i], fixed = T) == TRUE) {
            df$level_1[i] <- 'baseline'
        }
        if (grepl(".G.", indicator$indID[i], fixed = T) == TRUE) {
            df$level_1[i] <- 'geographic'
        }
        if (grepl("FUN", indicator$indID[i], fixed = T) == TRUE) {
            df$level_2[i] <- 'funding'
        }
        if (grepl("HUM", indicator$indID[i], fixed = T) == TRUE) {
            df$level_2[i] <- 'humanitarian'
        }
        if (grepl("HTH", indicator$indID[i], fixed = T) == TRUE) {
            df$level_2[i] <- 'health'
        }
        if (grepl("OTH", indicator$indID[i], fixed = T) == TRUE) {
            df$level_2[i] <- 'other'
        }
        if (grepl("ECO", indicator$indID[i], fixed = T) == TRUE) {
            df$level_2[i] <- 'economic'
        }
        if (grepl("POP", indicator$indID[i], fixed = T) == TRUE) {
            df$level_2[i] <- 'population'
        }
        if (grepl("EDU", indicator$indID[i], fixed = T) == TRUE) {
            df$level_2[i] <- 'education'
        }
        if (grepl("LOG", indicator$indID[i], fixed = T) == TRUE) {
            df$level_2[i] <- 'logistics'
        }
        if (grepl("NUT", indicator$indID[i], fixed = T) == TRUE) {
            df$level_2[i] <- 'nutrition'
        }
        if (grepl("WSH", indicator$indID[i], fixed = T) == TRUE) {
            df$level_2[i] <- 'water'
        }
        if (grepl("PRO", indicator$indID[i], fixed = T) == TRUE) {
            df$level_2[i] <- 'protection'
        }
    }
    return(df)
}
data <- classifyIndicators(indicator)

# making network data
makeNetwork <- function(df = NULL) {
#     groups <- data.frame(group_name = c('level_0', 'level_1', 'level_2'), 
#                          group_color = c(1, 2, 3))
#     df <- merge(df, groups, by.x = 'variable', by.y = 'group_name', all.x = TRUE)
    df$indID <- NULL
    df$units <- NULL
    df <- melt(df, id.vars = c('name', 'level_0', 'level_1'))
    df$variable <- NULL
    x <- data.frame(df$level_1, df$value)
    y <- data.frame(df$value, df$name)
    names(x) <- c('level_0', 'level_1')
    names(y) <- c('level_0', 'level_1')
    df$name <- NULL
    df$value <- NULL
    df <- rbind(df, x, y)
    df$value <- 1
    df$groupsource <- 1
    names(df) <- c('target', 'source', 'value', 'groupsource')
    tab <- data.frame(table(network_data$source))
    tab$grouptarget <- 1:nrow(tab)
    names(tab) <- c('source', 'weight', 'grouptarget')
    df <- merge(df, tab, by = 'source', all.x = TRUE)
return(df)
} 
network_data <- makeNetwork(data)

# writing CSV
write.csv(network_data, 'data.csv', row.names = FALSE)

# original column names
# source    target	value	groupsource	grouptarget
 