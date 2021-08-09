## Some initial creation of data files for the Eden
rm(list=ls())
graphics.off()
library(raster)

## read in the shape files of the Eden outline
ctch <- data.frame(id=c(76007,76003,76005,76017,76008,76010,76022),
                   label=c("Eden at Sheepmount","Eamont at Udford","Eden at Temple Sowerby",
                           "Eden at Great Corby","Irthing at Greenholme",
                           "Petteril at Harraby Green","Caldew at Cummersdale"))

tmp <- rep(list(NULL),nrow(ctch))
for(ii in 1:nrow(ctch)){
    tmp[[ii]] <- shapefile(file.path(".",ctch$id[ii],ctch$id[ii]))
}

map <- as(tmp[[1]],"SpatialPolygons")
for(ii in 2:nrow(ctch)){
    map <- union(map,as(tmp[[ii]],"SpatialPolygons"))
}

map <- SpatialPolygonsDataFrame(map,ctch)


shapefile(map,"./eden_data/unprocessed/Eden_Catchment")

## plot example
## plot(map)
## rgeos::polygonsLabel(map,labels=map@data$label,method="buffer")


## read the UK tif and crop to the size of the sheepmount basin
rst <- raster("/data/OrdanceSurvey/DEM/merge/gb50.tif")
crs(rst) <- crs(map) # the k value is different by 3e-10!
dem <- crop(rst,map,snap="out")
dem <- aggregate(dem,2) # collapse to 100m resolution
writeRaster(dem,"./eden_data/unprocessed/Eden_DEM.tif",overwrite=TRUE)

## read the UK river network and crop to the size of the sheepmount basin
lnk <- shapefile("/data/OrdanceSurvey/RiverNetwork/data/WatercourseLink")
rvr <- crop(lnk,map,snap="out")
shapefile(rvr,"./eden_data/unprocessed/Eden_River_Network",overwrite=TRUE)

## read in urban areas from the census and add
urb <- shapefile("Built-up_Areas_(December_2011)_Boundaries_V2/Built-up_Areas_(December_2011)_Boundaries_V2")
urb <- spTransform(urb,crs(map))
twn <- crop(urb,map,snap="out")
shapefile(twn,"./eden_data/unprocessed/Eden_Urban",overwrite=TRUE)


## plot that lot to ensure it makes sense
plot(dem); plot(map,add=TRUE); plot(rvr,col="blue",add=TRUE); plot(twn,col="grey",add=TRUE)

## process rainfall for Feb 2020
brk <- brick("/data/NASA/IMERG/ncdf/gb/imerg_tp_2020_02.nc")
prcp <- crop(brk,projectExtent(dem,crs(brk)),snap="out")

prcp@z[["time"]] <- as.POSIXct(prcp@z[["time"]],tz="GMT") ## not needed?

## this works but need to change names etc.
writeRaster(prcp,"./eden_data/unprocessed/Eden_Precip.nc",varname="Precipitation", varunit="m", 
            longname="IMERGv6 final precipitation over preceding 30 minutes",
            xname="Longitude",   yname="Latitude", zname='time',
            zunit="seconds since 1970-01-01 00:00:00",overwrite=TRUE)

## copy any files directly across as needed
file.copy("Eden_Gauge_Sites.csv","./eden_data/unprocessed/Eden_Gauge_Sites.csv",overwrite=TRUE)

## pack it all up into a zip file
zip("../eden_data.zip","./eden_data")

## getting series from raster brick
#rst <- brk[[1]]
#rst[] <- 1:ncell(rst)
#dem <- raster("dem.tif"); tmp <- projectRaster(rst,dem,method="ngb")

