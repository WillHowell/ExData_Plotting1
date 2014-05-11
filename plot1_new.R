#use sqldf to load data into a sqllite db and perform filtering there
#this is much faster than other approaches
#some useful links:
#http://www.cerebralmastication.com/2009/11/loading-big-data-into-r/
#http://stackoverflow.com/questions/4332976/how-to-import-csv-into-sqlite-using-rsqlite

#load the lib
library("sqldf")

#if the table exists from ta previous run, delete it
sqldf("drop table if exists main.elec", dbname="testingdb")

#read the raw text file into main.elec
read.csv.sql("Data//household_power_consumption.txt", sql = "create table main.elec as select * from file",
dbname = "testingdb",sep=";")

#use sql to filter to the two days we're interessted in and load that into "filtered"
filtered <- sqldf("select * from main.elec where Date = '1/2/2007' or Date = '2/2/2007'", dbname = "testingdb")

windows()
hist(filtered$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.copy(png, file="plot1.png")
dev.off()