#load the lib
library("sqldf")

#if the table exists from a previous run, delete it
#sqldf("drop table if exists main.elec", dbname="testingdb")

#read the raw text file into main.elec
#read.csv.sql("Data//household_power_consumption.txt", sql = "create table main.elec as select * from file",
#             dbname = "testingdb",sep=";")

#use sql to filter to the two days we're interessted in and load that into "filtered"
filtered <- sqldf("select * from main.elec where Date = '1/2/2007' or Date = '2/2/2007'", dbname = "testingdb")

#cast the character fields for date and time as a new datetime field
filtered$datetime <- strptime(paste(filtered$Date,  filtered$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

windows()
plot(filtered$datetime,filtered$Global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png, file="plot2.png")
dev.off()