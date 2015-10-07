##set working directory
## [ToDO:] Remove this section before submission
setwd("C:\\santiago.silvestrini\\Training\\Cloudera\\JH DS 04\\Course Project 1\\ExData_Plotting1")

dataFolder <- "../data" ## data is placed one level below WD folder
fileName <- "household_power_consumption.txt"

fileLocation <- file.path(dataFolder, fileName)

epcData <- read.table(
    file = fileLocation,
    header = FALSE,
    skip = 66637, #from 2007-02-01 
    nrows = 2880, #to 2007-02-02
    sep = ";",
    na.strings = c("?", ""),
    stringsAsFactors = FALSE,
    col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

## Convert Date Field to Date Class
epcData$Date <- as.Date(epcData$Date, format = "%d/%m/%Y")
epcData$TimeTemp <- paste(epcData$Date, epcData$Time)
epcData$Time <- strptime(epcData$TimeTemp, format = "%Y-%m-%d %H:%M:%S")
epcData$TimeTemp <- NULL

## Inspect data
head(epcData)
tail(epcData)
str(epcData)

## Plot 1 - Global Active Power
## Type: Histogram
## Y Axis: Frequency
## X Axis: Global Active Power (Global_active_power)

hist(
        epcData$Global_active_power
        , col = "red"
        , main = "Global Active Power"
        , xlab = "Global Active Power (kilowatts)"
        , cex.axis = 1 # relative size of axis text
        , cex.lab = 1  # relateive size of axis labels
        , cex.main = 1.2  # relative size of title text
        , mgp = c(3, 1, 0) # margin in mex units for axis title, labels and lines
        #,family = "sans"
)

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
