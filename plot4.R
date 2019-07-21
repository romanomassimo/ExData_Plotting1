library(dplyr)

# Download Zip File
setwd("wdpath")

if (!file.exists("CourseraWK1.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, "CourseraWK1.zip", method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip("CourseraWK1.zip") 
}

# Read data
ElcPowCon <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE) %>% 
  tbl_df()  %>%
  ## filter data
  mutate(DateTime=paste(Date,Time)) %>%
  mutate(Date=as.Date(Date,format="%d/%m/%Y")) %>%
  filter(Date == "2007-2-1" | Date == "2007-2-2")

## format DateTime
ElcPowCon$DateTime <- strptime(ElcPowCon$DateTime, format="%d/%m/%Y %H:%M:%S")

# plot 

png("plot4.png",width = 480, height = 480)
par(mfrow = c(2, 2))

## plot1
a <-  ElcPowCon %>%
  mutate(Global_active_power=as.numeric(Global_active_power))
plot(a$DateTime, a$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")


## plot2
a <-  mutate(a, Voltage=as.numeric(Voltage))
plot(a$DateTime, a$Voltage, type="l", xlab="datetime", ylab="Voltage")

## plot3
a <-  a
  mutate(Sub_metering_1=as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2=as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3=as.numeric(Sub_metering_3))

plot(a$DateTime, a$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering", col="black")
lines(a$DateTime, a$Sub_metering_2, col="red")
lines(a$DateTime, a$Sub_metering_3, col="blue")
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1), col = c("black","red","blue"),
       box.lty=0)

## plot4
a <-  mutate(a, Global_reactive_power=as.numeric(Global_reactive_power))
plot(a$DateTime,a$Global_reactive_power, type="l", xlab = "datetime", ylab="Global_reactive_power")

dev.off()
