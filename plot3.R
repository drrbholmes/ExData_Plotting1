library("data.table")

setwd("~/Dropbox/coursera/ExData_Plotting1/Exploratory Analysis")
#Reads in data from file then subsets data for specified dates
power_DT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation Peng RP chapter 9
power_DT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day Peng RP chpater 9
power_DT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02 Peng RP chapter 9
power_DT <- power_DT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]
## Peng EDA
png("plot3.png", width=480, height=480)

# Plot 3 Peng EDA 
plot(power_DT[, dateTime], power_DT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power_DT[, dateTime], power_DT[, Sub_metering_2],col="red")
lines(power_DT[, dateTime], power_DT[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()