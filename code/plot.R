# script for plotting metrics from

# the indicators data
# ind <- read.csv('frog_data/csv/denorm_data.csv')

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

  plot(pdata$indDate, pdata$indValue, type="b", main=unique(pdata$indicator_name), ylab=print(unique(pdata$units)), xlab="year")
  if (toFile) {
   dev.copy(png,paste(region,indID,".png",sep=""))
      dev.off()
  }
}

# test
#plotIndicator("KEN","CH080",TRUE)

# plot all indicators
plotAllIndicators <- function (region="KEN") {
ind<-ind[ind$region==region,]
for (i in unique(ind$indID)) {
#    print(paste('printing',i))
    plotIndicator("KEN", i, TRUE)
}
}
plotAllIndicators()
