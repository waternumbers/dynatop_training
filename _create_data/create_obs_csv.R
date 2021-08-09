## read in the mat file and generate a csv of data suitable for reading in to R
rm(list=ls())
graphics.off()

library(xts)

## read in observed data from Barry's file
obs <- read.zoo("EdenSheepmount_Q.csv",header=TRUE,sep=",",format="%d/%m/%Y %H:%M",tz="GMT")
obs <- as.xts(obs) ## convert from zoo to xts
names(obs) <- "Sheepmount_obs"

## trim to feb 2020
obs <- obs["2020-02-01::2020-02-29"]
obs <- obs[-1,]
## write to csv
fn <- "./eden_data/unprocessed/Eden_Flow.csv"
write.zoo(obs,fn,sep=",")

## command to read back in...
tmp <- as.xts(read.zoo(fn,header=TRUE,sep=",",drop=FALSE))
