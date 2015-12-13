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
png(file="plot2.png", width=480, height=480, bg="transparent")

#PLOT LINECHART
library(lubridate)
date_time <- dmy_hms(paste(raw_data$Date,raw_data$Time))
plot(date_time,
     raw_data$Global_active_power, 
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

#CLOSE PNG FILE DEVICE
dev.off()