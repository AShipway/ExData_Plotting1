library(dplyr)
library(lubridate)

main_table<-read.table("./household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")

main_table$Date<-as.Date(main_table$Date, "%d/%m/%Y")

subset_table<-filter(main_table, main_table$Date == "2007-02-01" | main_table$Date == "2007-02-02")

subset_table$minutes<-period_to_seconds(hms(subset_table$Time))/60

for(i in 1441:2880){
  
  subset_table[i,10] = subset_table[i,10] + 1439
  
}


subset_table$Global_active_power<-as.numeric(subset_table$Global_active_power)
subset_table$Global_reactive_power<-as.numeric(subset_table$Global_reactive_power)
subset_table$Voltage<-as.numeric(subset_table$Voltage)
subset_table$Global_intensity<-as.numeric(subset_table$Global_intensity)
subset_table$Sub_metering_1<-as.numeric(subset_table$Sub_metering_1)
subset_table$Sub_metering_2<-as.numeric(subset_table$Sub_metering_2)
subset_table$Sub_metering_3<-as.numeric(subset_table$Sub_metering_3)

png("plot4.png", width = 480, height = 480)

par(mfcol = c(2,2))
par(mar = c(4,4,1,1))

#plot1
plot(subset_table$minutes, subset_table$Global_active_power, type="n", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)")

axis(1,c(0,1439,2878), labels = c("Thu", "Fri", "Sat"))

lines(subset_table$minutes, subset_table$Global_active_power)

#plot2
plot(c(subset_table$minutes, subset_table$minutes, subset_table$minutes), c(subset_table$Sub_metering_1, subset_table$Sub_metering_2, subset_table$Sub_metering_3), type="n", xaxt = "n", xlab = "", ylab = "Energy sub metering")

axis(1,c(0,1439,2878), labels = c("Thu", "Fri", "Sat"))

lines(subset_table$minutes, subset_table$Sub_metering_1, col = "black")
lines(subset_table$minutes, subset_table$Sub_metering_2, col = "red")
lines(subset_table$minutes, subset_table$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, xjust = 1, bty = "n")

#plot3
plot(subset_table$minutes, subset_table$Voltage, type="n", xaxt = "n", xlab = "datetime", ylab = "Voltage")

axis(1,c(0,1439,2878), labels = c("Thu", "Fri", "Sat"))

lines(subset_table$minutes, subset_table$Voltage)

#plot4
plot(subset_table$minutes, subset_table$Global_reactive_power, type="n", xaxt = "n", xlab = "datetime", ylab = "Global_reactive_power")

axis(1,c(0,1439,2878), labels = c("Thu", "Fri", "Sat"))

lines(subset_table$minutes, subset_table$Global_reactive_power)




dev.off()