URL <- "http://www.fueleconomy.gov/feg/epadata/14data.zip"

if(! file.exists("./data/14data.zip")) {
    dir.create("./data/")
    download.file(URL, "./data/14data.zip", method="wget")
    unzip("./data/14data.zip", exdir="./data")
    filePath=paste0("./data/", grep(".xlsx", list.files("./data/"), value=TRUE))
    
    library(xlsx)
    DF <- read.xlsx2(filePath, sheetName="FE Guide")
    
    DFs <- subset(DF, select=c("Mfr.Name", "X..Cyl", "Trans", 
                               "City.FE..Guide....Conventional.Fuel") )   
    write.csv(DFs, paste(filePath, "_subset.csv"))
    rm(DF);
    rm(DFs);
}

filePathCSV=paste0("./data/", grep(".csv", list.files("./data/"), value=TRUE))
DFs <- read.csv(filePathCSV, header=TRUE)
DFs <- transform(DFs, Trans <- as.factor(Trans))

names(DFs)[names(DFs)=="City.FE..Guide....Conventional.Fuel"] = c("City.MPG") 
