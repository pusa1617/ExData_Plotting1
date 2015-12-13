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
png(file="plot4.png", width=480, height=480, bg="transparent")

#OVERALL SETTINGS OF 4 PLOTS 
par(mfrow = c(2,2), mar=c(6,4.3,3,1), lwd=0.1, cex.lab=1, cex.axis=1)

library(lubridate)
date_time <- dmy_hms(paste(raw_data$Date,raw_data$Time))

#1ST PLOT - DATETIME VS. GLOBAL ACTIVE POWER
plot(date_time,
     raw_data$Global_active_power, 
     type="l",
     ylab="Global Active Power",
     xlab="")

#2ND PLOT - DATETIME VS. VOLTAGE
plot(date_time,
     raw_data$Voltage, 
     type="l",
     ylab="Voltage",
     xlab="datetime")

#3RD PLOT - DATETIME VS. ENERGY SUBMETERING
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
legend("topright", legend = leg.txt, lwd=1, col=c("black","red","blue"), bty="n", cex=0.8)

#4th PLOT - DATETIME VS. GLOBAL REACTIVE POWER
plot(date_time,
     raw_data$Global_reactive_power, 
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

#CLOSE PNG FILE DEVICE
dev.off()
