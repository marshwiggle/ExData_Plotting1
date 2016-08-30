library(utils)

if( !(file.exists("household_power_consumption.txt")) ){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata_data_household_power_consumption.zip")
  unzip("exdata_data_household_power_consumption.zip")
}
consumption_tbl <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
consumption_tbl$datetime <- strptime(paste(consumption_tbl$Date, consumption_tbl$Time), "%d/%m/%Y %H:%M:%S")

selected_rows <- consumption_tbl[as.Date(consumption_tbl$Date, "%d/%m/%Y") %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]

png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(selected_rows, plot(datetime, Global_active_power, type="l", xlab = "", ylab ="Global Active Power (kilowatts)"))

with(selected_rows, plot(datetime, Voltage, type="l", xlab = "", ylab ="Voltage"))

with(selected_rows, plot(datetime, Sub_metering_1, type="l", xlab = "", ylab ="Energy sub metering"))
with(selected_rows, lines(datetime, Sub_metering_2, col="red"))
with(selected_rows, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), col=c("black", "red", "blue"))

with(selected_rows, plot(datetime, Global_reactive_power, type="l", xlab = "", ylab ="Global reactive power"))
dev.off()
