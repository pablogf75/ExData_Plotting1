#Reading data
fich <- file("household_power_consumption.txt")
hpc <- read.table(text = grep("^[1,2]/2/2007", readLines(fich), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)
hpc$Date <- as.Date(hpc$Date,format="%d/%m/%Y")
hpc$Global_active_power <- as.numeric(hpc$Global_active_power)
hpc$Global_reactive_power <- as.numeric(hpc$Global_reactive_power)
hpc$Voltage <- as.numeric(hpc$Voltage)
hpc$Global_intensity <- as.numeric(hpc$Global_intensity)
hpc$Sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
hpc$Sub_metering_2 <- as.numeric(hpc$Sub_metering_2)
hpc$Sub_metering_3 <- as.numeric(hpc$Sub_metering_3)
## Subsetting the data
hpc.sub <- subset(hpc, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(hpc)
## Converting dates
hpc.sub$DateTime <- paste(hpc.sub$Date, hpc.sub$Time)
hpc.sub$DateTime <- strptime(hpc.sub$DateTime, format="%Y-%m-%d %H:%M:%S")
# Generating Plot 3 and saving as png
png(filename="plot3.png", width=480, height=480, units="px")
plot(hpc.sub$DateTime, hpc.sub$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(hpc.sub$DateTime, hpc.sub$Sub_metering_2, type = "l", col = "red")
lines(hpc.sub$DateTime, hpc.sub$Sub_metering_3, type = "l", col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=1.0)
dev.off()
