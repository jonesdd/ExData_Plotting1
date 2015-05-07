# plot1.R
# This file contains the R code to produce plot 1.

#first I download the file to the curent working directory and save it as temp.zip.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "temp.zip", method = "curl")
#with the file saved i sue unz to upzip the file and extract the txt file household_power_consumption.txt, using read.table I save the data from the text file into raw.data. 
raw.data<-read.table(unz("temp.zip","household_power_consumption.txt"),sep = ";", header = TRUE, stringsAsFactors = FALSE)
#next I i filter out the data for 1/2/2007 and 2/2/2007 and store it in power.data.
power.data<-raw.data[(raw.data$Date =="1/2/2007" | raw.data$Date =="2/2/2007"),]
#convert the Sub_metering_1, Sub_metering_2, Sub_metering_3, Global_active_power and Voltage, data from character to numeric
power.data$Sub_metering_1<-as.numeric(power.data$Sub_metering_1)
power.data$Sub_metering_2<-as.numeric(power.data$Sub_metering_2)
power.data$Sub_metering_3<-as.numeric(power.data$Sub_metering_3)
power.data$Global_active_power<-as.numeric(power.data$Global_active_power)
power.data$Voltage<-as.numeric(power.data$Voltage)
#combine and convert the data and time columns into a single column of datetime.
power.data$Date_Time <-strptime(paste(power.data$Date,power.data$Time),"%d/%m/%Y %H:%M:%S")


#split graphics device up to receive 4 plots.
par(mfrow=c(2,2))


#Add first plot and line to graphics device.
plot(power.data$Date_Time,power.data$Global_active_power, ylab="Global Active Power (kilowatts)",xlab="", type="n")
lines(power.data$Date_Time,power.data$Global_active_power,type = "l")

#Add second plot and line to graphics device.
plot(power.data$Date_Time,power.data$Voltage,xlab="datetime", type="n")
lines(power.data$Date_Time,power.data$Voltage,type = "l")

#Add third plot, line, and legend to graphics device.
plot(power.data$Date_Time,power.data$Sub_metering_1, ylab="Energy sub metering",xlab="", type="n")
lines(power.data$Date_Time,power.data$Sub_metering_1,type = "l")
lines(power.data$Date_Time,power.data$Sub_metering_2,type = "l",col="red")
lines(power.data$Date_Time,power.data$Sub_metering_3,type = "l",col="blue")
legend("topright",lty=c(1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Add fourth plot and line to graphics device.
plot(power.data$Date_Time,power.data$Global_reactive_power,xlab="datetime", type="n")
lines(power.data$Date_Time,power.data$Global_reactive_power,type = "l")
#copy the plot to a png file called plot4.png.
dev.copy(png, file="plot4.png")
dev.off()

#par(mfrow=c(1,1))