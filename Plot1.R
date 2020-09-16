
# This R script generates a histogram of Global active power with dates 1/2/2007 ~ 2/2/2007


## Create tempfile
temp <- tempfile()

## Downloads zipped data
download.file(
  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
  temp
)

## Reads zipped text data into table
datatable <-
  read.table(unz(temp, "household_power_consumption.txt"),
             skip = 1,
             sep = ";")

## delete temp file
unlink(temp)
data <- datatable
## rename variables in data table
names(data) <-
  c(
    "Date",
    "Time",
    "Global_active_power",
    "Global_reactive_power",
    "Voltage",
    "Global_intensity",
    "Sub_metering_1",
    "Sub_metering_2",
    "Sub_metering_3"
  )

## format date
data$Data <- as.Date(data$Date, format = "%d/%m/%Y")

## create subset table within 1/2/2007 ~ 2/2/2007
subData <-
  filter(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

## format global active power into numeric
subData$Global_active_power <-
  as.numeric(subData$Global_active_power)

par(mfrow=c(1,1))
## Creates histogram of global active power from subtable
hist(
  subData$Global_active_power,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)"
)
