
# This R script generates a graph between time/date and Global active power with dates 1/2/2007 ~ 2/2/2007


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


## create subset table within 1/2/2007 ~ 2/2/2007
subData <-
  filter(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

## format global active power into numeric
subData$Global_active_power <-
  as.numeric(subData$Global_active_power)

## creates datetime column into data table
subData["Datetime"] =   with(subData, dmy(Date) + hms(Time))

par(mfrow=c(1,1))
## Plots graph
plot(
  subData$Datetime,
  subData$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Data (kilowatts)"
)
