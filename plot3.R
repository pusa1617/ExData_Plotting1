#IMPORT THE SPECIFIC DATA ROWS FROM TXT FILE 
raw_data <- read.table(
        "household_power_consumption.txt",
        col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                      "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                      "Sub_metering_3"),
        sep=";",
        skip=66637,
        nrows=2881,
        na.strings="?")

#CONVERT DATE AND TIME VARIABLES
as.Date(raw_data$Date)
strptime(raw_data$Time, format="%H:%M:%S")

#OPEN PNG DEVICE
png(file="plot3.png", width=480, height=480, bg="transparent")

#PLOT LINECHARTS
library(lubridate)
date_time <- dmy_hms(paste(raw_data$Date,raw_data$Time))
plot(date_time,
     raw_data$Sub_metering_1, 
     type="n",
     ylab="Energy sub metering",
     xlab="")
points(date_time,
       raw_data$Sub_metering_1,
       type="l",
       col="black")
points(date_time,
       raw_data$Sub_metering_2,
       type="l",
       col="red")
points(date_time,
       raw_data$Sub_metering_3,
       type="l",
       col="blue")
leg.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", legend = leg.txt, lwd=1, col=c("black","red","blue"))

#CLOSE PNG FILE DEVICE
dev.off()