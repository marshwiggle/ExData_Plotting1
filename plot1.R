library(utils)

if( !(file.exists("household_power_consumption.txt")) ){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata_data_household_power_consumption.zip")
  unzip("exdata_data_household_power_consumption.zip")
}
consumption_tbl <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
consumption_tbl$datetime <- strptime(paste(consumption_tbl$Date, consumption_tbl$Time), "%d/%m/%Y %H:%M:%S")

selected_rows <- consumption_tbl[as.Date(consumption_tbl$Date, "%d/%m/%Y") %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]


png(filename="plot1.png", width=480, height=480)
hist(selected_rows$Global_active_power, col="red", breaks = 12, xlab = "Global Active Power (kilowatts)", ylab="Frequency", main="Global active power")
dev.off()