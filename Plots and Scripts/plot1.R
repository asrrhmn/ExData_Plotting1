#Load required library
 library(dplyr)
#set Path fo the workingdirectory where
#required data file is stores
lpath <- getwd()
#retrieve the file using read.delim as we are working with
#delimited text file with delimited symbol as ";"
powerdf <- read.delim(file.path(lpath,"/household_power_consumption.txt")
                      ,sep=";",na.strings = "?")
#filter for dates 2007-02-01 and 2007-02-02
powerf1 <- powerdf%>% filter(DateTime>="2007-02-01" & DateTime < "2007-02-03")
#2880 obs filtered to f1

#plot to file "plot1.png"
png("plot1.png",width=480,height=480)
hist(powerf1$Global_active_power,col="red", xlab="Global Active Power(Kilowatts)",breaks=12,main="Global Active Power")
dev.off()