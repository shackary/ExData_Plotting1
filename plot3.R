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

## Convert sub meters to numeric
power$Sub_metering_1 <- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(as.character(power$Sub_metering_3))


## Initiate the plot
plot(power$Time, power$Sub_metering_1, xlab = "",
     ylab = "Energy sub metering", type = 'l')

## Add the other submeters
points(power$Time, power$Sub_metering_2, type='l', col="red")
points(power$Time, power$Sub_metering_3, type='l', col="blue")

## Add the legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"
                              ), col = c("black", "red", "blue"),
       lwd=1)

## Write to png
dev.copy(png, filename = "plot3.png")
dev.off()
