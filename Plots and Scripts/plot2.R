#Load required Libraries
library(dplyr)

# get required local path
lpath <- getwd()
#Download URL for source dataset ( the file if zipped to save network bandwidth)
URL <-"https://drive.google.com/file/d/1I4FGLXRiGQgMszrCSEg9yaX0fYYIztMt/view?usp=sharing"

if (!file.exists("household_power_consumption.txt")){
  download.file(URL,destfile = "power_cons_ds.7z")
  unzip("power_cons_ds.zip")
  #retrieve the file using read.delim as we are working with
  #delimited text file with delimited symbol as ";"
  powerdf <- read.delim(file.path(lpath,"/household_power_consumption.txt")
                        ,sep=";",na.strings = "?")
  print("Data set downloaded and is ready to use")
}else {
  #retrieve the file using read.delim as we are working with
  #delimited text file with delimited symbol as ";"
  powerdf <- read.delim(file.path(lpath,"/household_power_consumption.txt")
                        ,sep=";",na.strings = "?")
  print("Data set already exist and is ready to use")
}

#create new column DateTime
powerdf$DateTime <- as.POSIXct(paste(powerdf$Date, powerdf$Time), 
                               format = "%d/%m/%Y %H:%M:%S")

                      
#filter for dates 2007-02-01 and 2007-02-02
powerf2 <- powerdf%>% filter(DateTime>="2007-02-01" & DateTime < "2007-02-03")
#2880 obs filtered to powerf2

## save graph to Plot 2.png file
png("plot2.png", width=480, height=480)
plot(x = powerf2$DateTime
      , y = powerf2$Global_active_power
    , type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
