# plot1.R
# This file contains the R code to produce plot 1.

#first I download the file to the curent working directory and save it as temp.zip.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "temp.zip", method = "curl")
#with the file saved i sue unz to upzip the file and extract the txt file household_power_consumption.txt, using read.table I save the data from the text file into raw.data. 
raw.data<-read.table(unz("temp.zip","household_power_consumption.txt"),sep = ";", header = TRUE, stringsAsFactors = FALSE)
#next I i filter out the data for 1/2/2007 and 2/2/2007 and store it in power.data.
power.data<-raw.data[(raw.data$Date =="1/2/2007" | raw.data$Date =="2/2/2007"),]
#convert the Global_active_power data from character to numeric
power.data$Global_active_power<-as.numeric(power.data$Global_active_power) 
#create plot 1 in the screen graphic device. 
hist(power.data$Global_active_power,col="Red", xlab = "Global Active Power (kilowatts", main="Global Active Power")
#copy the histogram to a png file called plot1.png.
dev.copy(png, file="plot1.png")
dev.off()
