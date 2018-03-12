#Load required Library
library(dplyr)

# get required local path
lpath <- getwd()

#Download URL for source dataset ( the file is zipped to save network bandwidth)
URL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("household_power_consumption.txt")){
  print("Download in progress")
  download.file(URL,destfile = "power_cons_ds.zip")
  print("Download complete .....")
  print("File Unzip in progress .....")
  unzip('power_cons_ds.zip')
  print("Unzip complete, file should reside in Working directory")
  #retrieve the file using read.delim as we are working with
  #delimited text file with delimited symbol as ";"
  print("data set in text file is being read into data frame powerdf, execution in progress....")
  powerdf <- read.delim(file.path(lpath,"/household_power_consumption.txt")
                        ,sep=";",na.strings = "?")
  print("execution completed")
  print("Data set downloaded and is ready to use")
}else {
  #retrieve the file using read.delim as we are working with
  #delimited text file with delimited symbol as ";"
  print("data set in text file is being read into data frame powerdf, execution in progress....")
  powerdf <- read.delim(file.path(lpath,"/household_power_consumption.txt")
                        ,sep=";",na.strings = "?")
  print("execution completed")
  print("Data set and is ready to use")
}
#create new column DateTime
powerdf$DateTime <- as.POSIXct(paste(powerdf$Date, powerdf$Time), 
                               format = "%d/%m/%Y %H:%M:%S")


#filter for dates 2007-02-01 and 2007-02-02
powerf2 <- powerdf%>% filter(DateTime>="2007-02-01" & DateTime < "2007-02-03")
#2880 obs filtered to powerf3

#Plot 4
png("plot4.png", width=480, height=480)
par(mfrow= c(2,2))

#Sub plot 1
plot(x=powerf2$DateTime,y=powerf2$Global_active_power,type="l", 
     xlab="datetime",ylab="Global active power")

#Sub plot 2
plot(x=powerf2$DateTime,y=powerf2$Voltage,type="l", xlab="datetime",ylab="Voltage")

#Sub plot 3
plot(powerf2$DateTime,
     powerf2$Sub_metering_1,
     type = "l",
     xlab="",
     ylab="Energy Sub metering")
lines(powerf2$DateTime,powerf2$Sub_metering_2,col="red")
lines(powerf2$DateTime,powerf2$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"),
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1),
       bty="n",
       cex=.5)

#Sub plot 4
plot(x=powerf2$DateTime,y=powerf2$Global_reactive_power,
     type="l", xlab="datetime",ylab="Global_reactive_power")     

dev.off()


