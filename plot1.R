# . Dataset: Electric power consumption [20Mb]
# . Description: Measurements of electric power consumption in one household with a one-minute sampling rate over 
#               a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
# 
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#   1. Date: Date in format dd/mm/yyyy
#   2. Time: time in format hh:mm:ss
#   3. Global_active_power: household global minute-averaged active power (in kilowatt)
#   4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#   5. Voltage: minute-averaged voltage (in volt)
#   6. Global_intensity: household global minute-averaged current intensity (in ampere)
#   7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#   8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#   9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the 
#   strptime() and as.Date() functions.

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.


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

png("plot1.png", width = 480, height = 480)

hist(
        epcData$Global_active_power
        ,col = "red"
        ,main = "Global Active Power"
        ,xlab = "Global Active Power (kilowatts)"
        ,cex.axis = 1 # relative size of axis text
        ,cex.lab = 1  # relateive size of axis labels
        ,cex.main = 1.2  # relative size of title text
        ,mgp = c(3, 1, 0) # margin in mex units for axis title, labels and lines
        #,family = "sans"
)

dev.off()
