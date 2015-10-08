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

dev.copy(png, file = "plot4.png", width = 480, height = 480)

par(mfcol = c(2, 2), cex = .6 ) # setting layout: 2 columns by 2 rows

## Plot 1
## Type: Time Series
## Y Axis: Global Active Power (Global_active_power)
## X Axis: Time (Thu-Sat)

with(
    epcData
    , plot(
        Time
        , Global_active_power
        , xlab = ""
        , ylab = "Global Active Power"
        , type = "l" # line
    )
)

## Plot 3
## Type: Mutiple Time Series with Legends
## Y Axis: Energy sub metering (Sub_metering_X)
## X Axis: Time (Thu-Sat)

with(
    epcData
    , { 
        plot(
            Time
            , Sub_metering_1
            , xlab = ""
            , ylab = "Energy sub metering"
            , type = "l" # line
        )
        lines( 
            Time
            , Sub_metering_2
            , col = "red"
        )
        lines( 
            Time
            , Sub_metering_3
            , col = "blue"
        )
    }
)

legend(
    x = "topright" # position
    , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    , bty = "n" # box type
    , lty = 1 # line type: solid
    , col = c("black", "red", "blue")
)


## Plot 2
## Type: Time Series
## Y Axis: VOltage (Sub_metering_X)
## X Axis: Time (Thu-Sat)

with(
    epcData
    , plot(
        Time
        , Voltage
        , xlab = "datetime"
        , ylab = "Voltage"
        , type = "l"
    )
)

## Plot 4
## Type: Time Series
## Y Axis: Global Reactive Power (Sub_metering_X)
## X Axis: Time (Thu-Sat)

with(
    epcData
    , plot(
        Time
        , Global_reactive_power
        , xlab = "datetime"
        , ylab = "Global_reactive_power"
        , type = "l" # line
    )
)

dev.off()
