## read in the mat file and generate a csv of data suitable for reading in to R
rm(list=ls())
graphics.off()

library("R.matlab")
library(xts)

## read in observed data matrix
obs <- readMat("Corresponding_obs.mat")$Corresponding.obs
colnames(obs) <- c('Great.Corby','Linstock','Sheepmount','Greenholme','Harraby.Green','Cummersdale')

## trim obs and add offset (From matlab script for ICVRAM paper - values originally from Dave Leedal) - can't use rest of gauges since don't know the offset..
obs <- obs[,c('Sheepmount','Harraby.Green','Linstock')]
obs[,'Sheepmount'] <- obs[,'Sheepmount'] + 0.5373
obs[,'Harraby.Green'] <- obs[,'Harraby.Green'] + 0.0849
obs[,'Linstock'] <- obs[,'Linstock'] + 0

## read in time
dt <- readMat('EFP_Ds.mat')$Ds
## convert dt to seconds from fractions of a day
dt <- dt*60*60*24
## data is hourly but with rounding errors this doesn;t work so fix manually
dt <- round(dt/3600)*3600
dt <- as.POSIXct(dt, origin="0000-01-01 00:00:00",tz="GMT")

## convert to xts and trim to dec 2005
obs <- xts(obs,dt)
obs <- obs["2004-12-01::2005-01-31"]

## conver to flow from water level
## relationships taken from Eden_Ratings.csv
## sheepmount
idx <- 
idx <- (obs[,'Sheepmount']>0.549) & 
obs[,'Sheepmount'] <- obs[,'Sheepmount'] + 0.5373
obs[,'Harraby.Green'] <- obs[,'Harraby.Green'] + 0.0849
obs[,'Linstock'] <- obs[,'Linstock'] + 0


## write to csv
fn <- "./eden_data/unprocessed/Eden_Flow.csv"
write.zoo(obs,"test.csv",sep=",")

## commad to read back in...
tmp <- read.zoo(fn,header=TRUE,sep=",")

