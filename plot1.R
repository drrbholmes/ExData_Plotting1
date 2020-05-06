library("data.table")

setwd("~/Dropbox/coursera/ExData_Plotting1/Exploratory Analysis")


#Reads in data from file then subsets data for specified dates Peng RP Chapter 9
power_DT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents histogram from printing in scientific notation Peng RP pg 53-56
power_DT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type Peng RP pg 53-56
power_DT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
power_DT <- power_DT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
## Peng EDA 
png("plot1.png", width=480, height=480)

## Plot 1 Peng EDA
hist(power_DT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()