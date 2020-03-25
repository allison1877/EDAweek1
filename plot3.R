

# Code for plot 3

###### Read in and clean data ###############################################################################
power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE) # read in data - separated with ;
head(power) # Check how the data was read in

powersubset <- subset(power, Date=="2/2/2007" | Date =="1/2/2007")  # keep only 2007-02-01 and 2007-02-02

powersubset$DTG <- paste(powersubset$Date, " ", powersubset$Time)  # Combine date and time together

powersubset$DTG <- strptime(powersubset$DTG, "%d/%m/%Y %H:%M:%S") # set to POSIXlt format for future graphing
powersubset$DTG <- as.POSIXct(powersubset$DTG)

############################################################################################################
# Plot 3

powersubset$Sub_metering_1 <- as.numeric(as.character(powersubset$Sub_metering_1))
powersubset$Sub_metering_2 <- as.numeric(as.character(powersubset$Sub_metering_2))
powersubset$Sub_metering_3 <- as.numeric(as.character(powersubset$Sub_metering_3))

png(filename = "plot3.png", width = 480, height = 480) # output to png file   

with(powersubset, plot(DTG, Sub_metering_1, ylab = "Energy sub metering", xlab = " ", type = "l"))
lines(powersubset$DTG, powersubset$Sub_metering_2, col = "red")
lines(powersubset$DTG, powersubset$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))
dev.off()
