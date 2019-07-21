
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


# plot3
a <-  ElcPowCon %>%
  mutate(Sub_metering_1=as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2=as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3=as.numeric(Sub_metering_3))

png("plot3.png",width = 480, height = 480)
plot(a$DateTime, a$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering", col="black")
lines(a$DateTime, a$Sub_metering_2, col="red")
lines(a$DateTime, a$Sub_metering_3, col="blue")
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1), col = c("black","red","blue"))
dev.off()


