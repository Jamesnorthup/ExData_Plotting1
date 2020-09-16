# This R script generates a graph between metering1-3 and time/data with dates 1/2/2007 ~ 2/2/2007


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

## format Sub_metering_1 into numeric
subData$Sub_metering_1 <-
  as.numeric(subData$Sub_metering_1)

## format Sub_metering_2 into numeric
subData$Sub_metering_2 <-
  as.numeric(subData$Sub_metering_2)

## format Sub_metering_3 into numeric
subData$Sub_metering_3 <-
  as.numeric(subData$Sub_metering_3)

## creates datetime column into data table
subData["Datetime"] =   with(subData, dmy(Date) + hms(Time))


## Plots graph
par(mfrow=c(2,2))

## Plots graph
plot(
  subData$Datetime,
  subData$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Data"
)
plot(
  subData$Datetime,
  subData$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)

plot(
  subData$Datetime,
  subData$Sub_metering_1,
  type = "l",
  col = "black",
  xlab = "",
  ylab = "Energy sub metering"
)
points(subData$Datetime,
       subData$Sub_metering_2,
       type = "l",
       col = "red")
points(subData$Datetime,
       subData$Sub_metering_3,
       type = "l",
       col = "blue")
legend(
  "topright",
  lty = 1,
  col = c("black", "red", "blue"),
  bty = "n",
  cex=0.6,
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)


plot(
  subData$Datetime,
  subData$Global_reactive_power,
  type = "l",
  col = "black",
  xlab = "datetime",
  ylab = "Global_reactive_power"
)
