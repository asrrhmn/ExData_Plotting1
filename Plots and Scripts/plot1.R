#Load required Library
library(dplyr)

# get required local path
lpath <- getwd()

#Download URL for source dataset ( the file if zipped to save network bandwidth)
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
powerdf$Date <- as.Date(powerdf$Date,format="%d/%m/%Y")


#filter for dates 2007-02-01 and 2007-02-02
powerf1 <- powerdf%>% filter(Date>="2007-02-01" & Date < "2007-02-03")
#2880 obs filtered to f1

#plot to file "plot1.png"
png("plot1.png",width=480,height=480)
hist(powerf1$Global_active_power,col="red", xlab="Global Active Power(Kilowatts)",breaks=12,main="Global Active Power")
dev.off()