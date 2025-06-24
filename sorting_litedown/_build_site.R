## commands to build the training site
rm(list=ls())

## Not sure where all of this is - best just keep current zip file
## ## create the zip file of data
## unlink("eden_data.zip")
## setwd("./_create_data")
## zip("../eden_data.zip","./eden_data")
## setwd("../")

## create the zip file of R scripts
tmp <- list.files(".",pattern=".Rmd$")
out <- sapply(tmp,function(x){knitr::purl(x,documentation = 0,quiet=TRUE)})
unlink("dynatop_training_rcode.zip")
zip("dynatop_training_rcode.zip",out[file.size(out)>1])
unlink(out)

## remove existing folder of results and unzip zip file
unlink("./eden_data",recursive=TRUE)
unzip("eden_data.zip")       

## run to build the site
rmarkdown::clean_site(quiet=TRUE,preview=FALSE)
rmarkdown::render_site() #quiet=TRUE)

## create

