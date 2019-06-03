## Load required packages
library(dplyr)
library(lubridate)

## Read in the dataset and convert the date field
power <- read.csv2("household_power_consumption.txt", na.strings = "?")
power <- power %>% mutate(Date = dmy(Date))

## Get the dates used for this assignment
power <- power[power$Date == as.Date("2007-02-01") | 
                   power$Date == as.Date("2007-02-02"), ]

## Convert the Time field
power$Time <- strptime(paste(power$Date, power$Time), "%Y-%m-%d %H:%M:%S")

## Convert to kilowatts
power$Global_active_power <- as.numeric(as.character(power$Global_active_power))
power$Global_reactive_power <- as.numeric(as.character(power$Global_reactive_power))

## Convert sub meters and voltage to numeric
power$Sub_metering_1 <- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(as.character(power$Sub_metering_3))
power$Voltage <- as.numeric(as.character(power$Voltage))

## Prepare the columns and rows
par(mfrow = c(2,2))

## Generate plot #1
with(power, plot(Time, Global_active_power, type = "l",
                 ylab = "Global Active Power", xlab = ""))

## Generate plot #2
with(power, plot(Time, Voltage, type = "l",
                 ylab = "Voltage", xlab = "datetime"))

## Generate plot #3
plot(power$Time, power$Sub_metering_1, xlab = "",
     ylab = "Energy sub metering", type = 'l')

points(power$Time, power$Sub_metering_2, type='l', col="red")
points(power$Time, power$Sub_metering_3, type='l', col="blue")

legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"
), col = c("black", "red", "blue"),
lwd=1, cex = 0.5, bty = "n")


## Generate plot #4
with(power, plot(Time, Global_reactive_power, type = "l",
                 ylab = "Global_reactive_power", xlab = "datetime"))

## Write to png
dev.copy(png, filename = "plot4.png")
dev.off()
