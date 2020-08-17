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

png("plot2.png", width = 480, height = 480)

plot(subset_table$minutes, subset_table$Global_active_power, type="n", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)")

axis(1,c(0,1439,2878), labels = c("Thu", "Fri", "Sat"))

lines(subset_table$minutes, subset_table$Global_active_power)

dev.off()
