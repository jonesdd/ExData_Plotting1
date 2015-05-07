# plot1.R
# This file contains the R code to produce plot 1.

#first I download the file to the curent working directory and save it as temp.zip.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "temp.zip", method = "curl")
#with the file saved i sue unz to upzip the file and extract the txt file household_power_consumption.txt, using read.table I save the data from the text file into raw.data. 
raw.data<-read.table(unz("temp.zip","household_power_consumption.txt"),sep = ";", header = TRUE, stringsAsFactors = FALSE)
#next I i filter out the data for 1/2/2007 and 2/2/2007 and store it in power.data.
power.data<-raw.data[(raw.data$Date =="1/2/2007" | raw.data$Date =="2/2/2007"),]
#convert the Sub_metering_1, Sub_metering_2, and Sub_metering_3. data from character to numeric
power.data$Sub_metering_1<-as.numeric(power.data$Sub_metering_1)
power.data$Sub_metering_2<-as.numeric(power.data$Sub_metering_2)
power.data$Sub_metering_3<-as.numeric(power.data$Sub_metering_3)
#combine and convert the data and time columns into a single column of datetime.
power.data$Date_Time <-strptime(paste(power.data$Date,power.data$Time),"%d/%m/%Y %H:%M:%S")
#create plot 3 in the screen graphic device. 
plot(power.data$Date_Time,power.data$Sub_metering_1, ylab="Energy sub metering",xlab="", type="n")

#add line to the plot.
lines(power.data$Date_Time,power.data$Sub_metering_1,type = "l")
lines(power.data$Date_Time,power.data$Sub_metering_2,type = "l",col="red")
lines(power.data$Date_Time,power.data$Sub_metering_3,type = "l",col="blue")
#add legend to plot 3
legend("topright",lty=c(1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#copy the plot to a png file called plot3.png.
dev.copy(png, file="plot3.png")
dev.off()