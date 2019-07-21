
library(dplyr)

# Download Zip File
setwd("/Users/Mas/J&J/Coursera - Data Scientist Spec/4. Exploratory Data Analysis/WK1")

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
  filter(Date == "2007-2-1" | Date == "2007-2-2" )

# plot1
a <-  ElcPowCon %>%
  mutate(Global_active_power=as.numeric(Global_active_power))

png(filename="plot2.png", width = 480, height = 480)
hist(a$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power",
     col="red")
dev.off


