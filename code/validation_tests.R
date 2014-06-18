# Series of validation tests to see if the 
# data prepared for frog is matches the 
# data in the CPS + the CHD.
runValidation <- function(df = zValue) { 
    source('code/load_chd_list.R')
    
    # test for duplicates
    dups <- as.numeric(summary(duplicated(df))[2])
    if (dups < nrow(df)) message('Duplicates: FAIL!')
    else message('Duplicates: PASS.')
    
    # checking for consistency with the CHD. 
    in_chd <- summary(zIndicator$indID %in% chd_list$indID)
    tr <- as.numeric(in_chd[3])
    if (tr > nrow(chd_list)) message('CHD test: FAIL!')
    else message('CHD test: PASS.')
    
}