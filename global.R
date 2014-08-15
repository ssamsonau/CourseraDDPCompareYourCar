URL <- "http://www.fueleconomy.gov/feg/epadata/14data.zip"

if(! file.exists("./data/14data.zip")) {
    dir.create("./data/")
    download.file(URL, "./data/14data.zip", method="wget")
    unzip("./data/14data.zip", exdir="./data")
}

filePath=paste0("./data/", grep(".xlsx", list.files("./data/"), value=TRUE))

library(xlsx)
DF <- read.xlsx2(filePath, sheetName="FE Guide")

DFs <- subset(DF, select=c("Mfr.Name", "X..Cyl", "Trans", 
                           "City.FE..Guide....Conventional.Fuel") )   

names(DFs)[4] = c("City.MPG") 

DFs$City.MPG <- as.numeric(DFs$City.MPG)
