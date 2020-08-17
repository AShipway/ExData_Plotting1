library(dplyr)

main_table<-read.table("./household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")

main_table$Date<-as.Date(main_table$Date, "%d/%m/%Y")

subset_table<-filter(main_table, main_table$Date == "2007-02-01" | main_table$Date == "2007-02-02")

subset_table$Global_active_power<-as.numeric(subset_table$Global_active_power)
subset_table$Global_reactive_power<-as.numeric(subset_table$Global_reactive_power)
subset_table$Voltage<-as.numeric(subset_table$Voltage)
subset_table$Global_intensity<-as.numeric(subset_table$Global_intensity)
subset_table$Sub_metering_1<-as.numeric(subset_table$Sub_metering_1)
subset_table$Sub_metering_2<-as.numeric(subset_table$Sub_metering_2)
subset_table$Sub_metering_3<-as.numeric(subset_table$Sub_metering_3)

png("plot1.png", width = 480, height = 480)

hist(subset_table$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()