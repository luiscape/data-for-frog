data <- read.csv('frog_data/csv/value.csv')

# FY620	Total Country Pooled Fund Allocations	USD
# FY630	Total Country Humanitarian Funding Received	USD
# FA010	CAP Amount Required (Revised)	USD
# FA140	CAP Amount Received

fts <- data[data$indID == 'FY630', ]
col_fts <- fts[fts$region == 'COL', ]
col_fts$value <- as.numeric(as.character(col_fts$value))
col_fts$period <- as.Date(col_fts$period, format = '%Y')

library(ggplot2)
ggplot(col_fts) + theme_bw() +
    geom_line(aes(period, value), stat = 'identity', size = 1.3, color = "#0988bb") + scale_x_date(limits = c(as.Date('2000-01-01'), as.Date('2014-03-03')))