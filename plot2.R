# Read data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "power.zip")

unzip("power.zip")

data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

file.remove("power.zip", "household_power_consumption.txt")

data$Date <- strptime(data$Date, "%d/%m/%Y") 
data <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]
data$Datetime <- with(data, strptime(paste(format(Date, "%d/%m/%Y"), Time),
                                     "%d/%m/%Y %H:%M:%S"))

data[,3:(dim(data)[2]-1)] <- sapply(data[,3:(dim(data)[2]-1)], as.numeric)

# Plot
png("plot2.png")

with(data, plot(Datetime, Global_active_power, 
                ylab="Global Active Power (kilowatts)", xlab="", type="l"))

dev.off()
