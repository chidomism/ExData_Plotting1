rm(list=ls(all=TRUE))

#*** Packages ***
library(dplyr)
library(data.table)

#*** Working Directory ***
mydir <- "C:/Users/chidom/Dropbox/Coursera/Data Science Specialization/ExpoDataAnalysis/Week 1"
setwd(mydir)

##### Project 1 #####

## Downloads the file and put the file in the data folder

if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

power <- read.table(file, header=T, sep=";")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
data1 <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
data1$Global_active_power <- as.numeric(as.character(data1$Global_active_power))
data1$Global_reactive_power <- as.numeric(as.character(data1$Global_reactive_power))
data1$Voltage <- as.numeric(as.character(data1$Voltage))
data1 <- transform(data1, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
data1$Sub_metering_1 <- as.numeric(as.character(data1$Sub_metering_1))
data1$Sub_metering_2 <- as.numeric(as.character(data1$Sub_metering_2))
data1$Sub_metering_3 <- as.numeric(as.character(data1$Sub_metering_3))

# Plot 4

plot4 <- function() {
  par(mfrow=c(2,2))
  
  ##Plot 1
  plot(data1$timestamp,data1$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  ##Plot 2
  plot(data1$timestamp,data1$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  ##Plot 3
  plot(data1$timestamp,data1$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(data1$timestamp,data1$Sub_metering_2,col="red")
  lines(data1$timestamp,data1$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
  
  #Plot 4
  plot(data1$timestamp,data1$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  #OUTPUT
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
  cat("plot4.png has been saved in", getwd())
}
plot4()

