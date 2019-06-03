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

## Create the plot
hist(power$Global_active_power, col="red",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     )

## Write to png
dev.copy(png, filename = "plot1.png")
dev.off()