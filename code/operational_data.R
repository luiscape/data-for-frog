## Script for creating false operational data. 

# This script uses the following variables to determine its formula: 
# World Bank's Income Level classifimessageion. 
# Number of Reports on ReliefWeb (normalized).
# Population of the country.


# Getting the population and income level from the World Bank.
library(WDI)  # using the WDI package.
population_total <- WDI(country = 'all', 'SP.POP.TOTL', extra = TRUE)
field_operations <- read.csv('source_data/ocha_field_operation_by_status.csv')

# Population variable
latest_year <- as.numeric(summary(population_total$year)[6])
population <- subset(population_total, (year == latest_year))

# Income level factor
income_level <- c('Not classified', 'Low income', 'Lower middle income', 
            'Upper middle income', 'High income: nonOECD', 'High income: OECD')
in_factor <- c(10, 10, 8, 6, 4, 2)
income_factor <- data.frame(income_level, in_factor)

# Operation factor
op_status <- c('Closing', 'Downsizing', 'Ongoing', 'Startup / Increasing')
op_factor <- c(1, 1.1, 1.2, 1.3)
operation_factor <- data.frame(op_status, op_factor)

# ReliefWeb factor.
rw <- read.csv('source_data/rw-value.csv')
rw <- rw[rw$period == 2013, ]
rw <- rw[rw$indID == 'RW001', ]
for (i in 1:nrow(rw)) { 
    if (i == 1 ) rw$normalized <- rw$value[i] / sum(rw$value)
    else rw$normalized[i] <- rw$value[i] / sum(rw$value)
}
rw_data <- data.frame(rw$region, rw$value, rw$normalized)
names(rw_data) <- c('iso3', 'rw_value', 'rw_normalized')

# Preparing the dataset
ope_list <- field_operations$ISO3

x <- population[which(population$iso3c %in% ope_list), ]
pop_data <- data.frame(x$iso3c, x$SP.POP.TOTL, x$income)
names(pop_data) <- c('iso3', 'population', 'income_level')

# Merging final equation data.
a <- merge(pop_data, income_factor, by = "income_level")
eq_data <- merge(a, rw_data, by = 'iso3')


## Equation ##
# Calculating the Number of People Affected
for (i in 1:nrow(eq_data)) {
    if (i == 1) { 
        eq_data$people_affected <- 
        round(eq_data$population[i]*(eq_data$in_factor[i]*eq_data$rw_normalized[i]))
    }
    else { 
        eq_data$people_affected[i] <- 
        round(eq_data$population[i]*(eq_data$in_factor[i]*eq_data$rw_normalized[i]))
    }
}

# Calculating the share of people affected
for (i in 1:nrow(eq_data)) {
    if (i == 1) { 
        eq_data$pl_affected_share <- 
        round(eq_data$people_affected[i] / eq_data$population[i], 2)
    } 
    else { 
        eq_data$pl_affected_share[i] <- 
        round(eq_data$people_affected[i] / eq_data$population[i], 2)
    }
}

# Normalizing the data for the CHD format.
people_affected <- data.frame(eq_data$iso3, eq_data$people_affected)
pl_affected_share <- data.frame(eq_data$iso3, eq_data$pl_affected_share)
names(people_affected) <- c('region', 'value')
names(pl_affected_share) <- c('region', 'value')

# adding CHD codes
people_affected$indID <- 'OH080'
pl_affected_share$indID <- 'OH090'

# adding period
people_affected$period <- 2014
pl_affected_share$period <- 2014

# adding dsID
people_affected$dsID <- 'dummy_data'
pl_affected_share$dsID <- 'dummy_data'

# adding source
people_affected$source <- 'dummy_source'
pl_affected_share$source <- 'dummy_source'

# adding validation
source('code/is_number.R')
people_affected <- is_number(people_affected)
pl_affected_share <- is_number(pl_affected_share)

message('Creating the dataset table')
dsID <- 'dummy_data'
last_updated <- as.character(sort(AllReportData$created)[1])
last_scraped <- ScrapeMeta$scrape_time
name <- 'Dummy Data'
dtset <- data.frame(dsID, last_updated, last_scraped, name)

'OH010', 'OH080', 'OH020', 'OH030', 'OH040', 'OH050', 'OH060', 'OH070'

message('Creating indimessageor table')
indID <- c('RW001', 'RW002')  # We have to create the indIDs for the indicators.
name <- c('Number of Reports', 'Number of Disasters')
units <- 'Count'  # Not sure what unit I should add here.
indic <- data.frame(indID, name, units)

message('Creating the value table')
reports$indID <- 'RW001'
colnames(reports)[1] <- 'value'
colnames(reports)[2] <- 'period'
colnames(reports)[3] <- 'region'
reports$dsID <- 'reliefweb'
reports$source <- 'http://api.rwlabs.org/v1/reports'

source('code/is_number.R')
zValue <- is_number(zValue)

