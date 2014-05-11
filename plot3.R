#load the lib
library("sqldf")

#if the table exists from a previous run, delete it
sqldf("drop table if exists main.elec", dbname="testingdb")

#read the raw text file into main.elec
read.csv.sql("Data//household_power_consumption.txt", sql = "create table main.elec as select * from file",
             dbname = "testingdb",sep=";")

#use sql to filter to the two days we're interessted in and load that into "filtered"
filtered <- sqldf("select * from main.elec where Date = '1/2/2007' or Date = '2/2/2007'", dbname = "testingdb")

#cast the character fields for date and time as a new datetime field
filtered$datetime <- strptime(paste(filtered$Date,  filtered$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

windows()

#add first series
plot(filtered$datetime,filtered$Sub_metering_1, type="l",col="black",ylab="Energy sub metering", xlab="")

#add second and third
lines(filtered$datetime,filtered$Sub_metering_2, type="l",col="red")
lines(filtered$datetime,filtered$Sub_metering_3, type="l",col="blue")

#get the legend in, adjust for width of text
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1), 
       col=c("black","red","blue"),cex=0.8, ncol=1.2) 


dev.copy(png, file="plot3.png")
dev.off()