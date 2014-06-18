# Loading the current list of the CHD.
chd_list <- read.csv('source_data/chd_list.csv')

# Cleaning the codes. 
colnames(chd_list)[2] <- 'indID'
chd_list$is_code <- nchar(as.character(chd_list$indID)) >= 4
chd_list <- subset(chd_list, (is_code == 'TRUE'))  # cleaning headers.

chd_list <- data.frame(chd_list$indID, chd_list$Indicator.Name)
names(chd_list) <- c('indID', 'indicator_name')

# Cleaning the blank spaces.
# Apparently there are none ...
# for (i in 1:nrow(chd_list)) {
#     if ((chd_list[i, ] == "") == TRUE) {chd_list[i, ] <- NA }
#     else next
# }
# chd_list <- na.omit(chd_list)