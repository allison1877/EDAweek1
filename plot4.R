

# Code for plot 4

###### Read in and clean data ###############################################################################
power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE) # read in data - separated with ;
head(power) # Check how the data was read in

powersubset <- subset(power, Date=="2/2/2007" | Date =="1/2/2007")  # keep only 2007-02-01 and 2007-02-02

powersubset$DTG <- paste(powersubset$Date, " ", powersubset$Time)  # Combine date and time together

powersubset$DTG <- strptime(powersubset$DTG, "%d/%m/%Y %H:%M:%S") # set to POSIXlt format for future graphing
powersubset$DTG <- as.POSIXct(powersubset$DTG)

############################################################################################################
# Plot 4

powersubset$Global_active_power <- as.numeric(as.character(powersubset$Global_active_power))
powersubset$Global_reactive_power <- as.numeric(as.character(powersubset$Global_reactive_power))
powersubset$Sub_metering_1 <- as.numeric(as.character(powersubset$Sub_metering_1))
powersubset$Sub_metering_2 <- as.numeric(as.character(powersubset$Sub_metering_2))
powersubset$Sub_metering_3 <- as.numeric(as.character(powersubset$Sub_metering_3))
powersubset$Voltage <- as.numeric(as.character(powersubset$Voltage))


png(filename = "plot4.png", width = 480, height = 480) # output to png file   

par(mfrow = c(2,2))

# top left
with(powersubset, plot(DTG, Global_active_power, ylab = "Global Active Power", xlab = " ", type = "l"))

# top right
with(powersubset, plot(DTG, Voltage, xlab = "datetime", type = "l"))

# bottom left
with(powersubset, plot(DTG, Sub_metering_1, ylab = "Energy sub metering", xlab = " ", type = "l"))
lines(powersubset$DTG, powersubset$Sub_metering_2, col = "red")
lines(powersubset$DTG, powersubset$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), bty = "n")

# bottom right
with(powersubset, plot(DTG, Global_reactive_power, xlab = "datetime", type = "l"))

dev.off()
