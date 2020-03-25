
# Code for plot 2

###### Read in and clean data ###############################################################################
power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE) # read in data - separated with ;
head(power) # Check how the data was read in

powersubset <- subset(power, Date=="2/2/2007" | Date =="1/2/2007")  # keep only 2007-02-01 and 2007-02-02

powersubset$DTG <- paste(powersubset$Date, " ", powersubset$Time)  # Combine date and time together

powersubset$DTG <- strptime(powersubset$DTG, "%d/%m/%Y %H:%M:%S") # set to POSIXlt format for future graphing
powersubset$DTG <- as.POSIXct(powersubset$DTG)

############################################################################################################
# Plot 2

powersubset$Global_active_power <- as.numeric(as.character(powersubset$Global_active_power))

png(filename = "plot2.png", width = 480, height = 480) # output to png file   

with(powersubset, plot(DTG, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = " ", type = "l"))
dev.off()
