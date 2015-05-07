# plot2.R
# This file contains the R code to produce plot 2.

#first I download the file to the curent working directory and save it as temp.zip.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "temp.zip", method = "curl")
#with the file saved i sue unz to upzip the file and extract the txt file household_power_consumption.txt, using read.table I save the data from the text file into raw.data. 
raw.data<-read.table(unz("temp.zip","household_power_consumption.txt"),sep = ";", header = TRUE, stringsAsFactors = FALSE)
#next I i filter out the data for 1/2/2007 and 2/2/2007 and store it in power.data.
power.data<-raw.data[(raw.data$Date =="1/2/2007" | raw.data$Date =="2/2/2007"),]
#convert the Global_active_power data from character to numeric
power.data$Global_active_power<-as.numeric(power.data$Global_active_power)
#combine and convert the data and time columns into a single column of datetime.
power.data$Date_Time <-strptime(paste(power.data$Date,power.data$Time),"%d/%m/%Y %H:%M:%S")
#create plot 2 in the screen graphic device. 
plot(power.data$Date_Time,power.data$Global_active_power, ylab="Global Active Power (kilowatts)",xlab="", type="n")
#add line to the plot.
lines(power.data$Date_Time,power.data$Global_active_power,type = "l")
#copy the plot to a png file called plot2.png.
dev.copy(png, file="plot2.png")
dev.off()
