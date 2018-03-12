#Load required Libraries
library(dplyr)

# get required local path
lpath <- getwd()

#retrieve the file using read.delim as we are working with
#delimited text file with delimited symbol as ";"
powerdf <- read.delim(file.path(lpath,"/household_power_consumption.txt")
                      ,sep = ";", na.strings = "?")

#create new column DateTime
powerdf$DateTime <- as.POSIXct(paste(powerdf$Date, powerdf$Time), 
                               format = "%d/%m/%Y %H:%M:%S")


#filter for dates 2007-02-01 and 2007-02-02
powerf3 <- powerdf%>% filter(DateTime>="2007-02-01" & DateTime < "2007-02-03")
#2880 obs filtered to powerf3

#Plot 3
png("plot3.png", width=480, height=480)
plot(powerf3$DateTime,
     powerf3$Sub_metering_1,
     type = "l",
     xlab="",
     ylab="Energy Sub metering")
     lines(powerf3$DateTime,powerf2$Sub_metering_2,col="red")
     lines(powerf3$DateTime,powerf2$Sub_metering_3,col="blue")
     legend("topright", col=c("black","red","blue"),
            c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
            lty=c(1,1),
            lwd=c(1,1))
dev.off()
