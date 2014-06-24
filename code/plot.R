# script for plotting metrics from

# the indicators data
print("loading from CSV...")
ind <- read.csv('frog_data/csv/denorm_data.csv')
print("loaded")

# de-factor numbers & date
ind$indValue <- as.numeric(ind$value)
ind$indDate <- as.Date(ind$period, format="%Y")

# filter for numeric indicators
ind <- ind[ind$is_number==1,]

# plot
plotIndicator <- function (region="KEN", indID="CH080", toFile=FALSE) {
  pdata <- ind[ind$region==region,]
  pdata <- pdata[pdata$indID==indID,]
  pdata <- pdata[with(pdata,order(indDate)),]

  # background should be white
  par(bg = "white")

  # name of plot output
  plotfn <- paste("plots/",region,"_",indID,".png", sep="")

  # output to file when we're in an external Rscript
  if (toFile) png(plotfn)

  # generate plot
  plot(pdata$indDate, pdata$indValue, type="b", main=unique(pdata$indicator_name), ylab=unique(pdata$units), xlab="year")

  # output to file if we're in R REPL
  if (toFile) {
#    dev.copy(png,plotfn)
    dev.off()
  }
}

# test
#plotIndicator("KEN","CH080",TRUE)

# plot all indicators
plotAllIndicators <- function (region="KEN") {
ind<-ind[ind$region==region,]
for (i in unique(ind$indID)) {
    print(paste('creating plot',i))
    plotIndicator("KEN", i, TRUE)
}
}
plotAllIndicators()
