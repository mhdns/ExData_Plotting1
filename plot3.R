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
png("plot3.png")

with(data, plot(Datetime, Sub_metering_1, 
                xlab="", ylab="Energy sub metering", type="l"))
lines(data$Datetime, data$Sub_metering_2, type = "l", col="red")
lines(data$Datetime, data$Sub_metering_3, type = "l", col="blue")

legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()