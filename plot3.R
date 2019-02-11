inputFile <- "household_power_consumption.txt"
con  <- file(inputFile, open = "r")

date <- c()
time <- c()
gActivePower <- c()
gReactivePower <- c()
voltage <- c()
gIntensity <- c()
subMetering1 <- c()
subMetering2 <- c()
subMetering3 <- c()

startDate <- as.Date("2007-02-01")
endDate <- as.Date("2007-02-02")

headers <- strsplit(readLines(con, n = 1, warn = FALSE), ";")
while (length(oneLine <- readLines(con, n = 1, warn = FALSE)) > 0) {
  myVector <- (strsplit(oneLine, ";"))
  currDate <- as.Date(myVector[[1]][1], "%d/%m/%Y")
  if(currDate == startDate || currDate == endDate){
    date <- c(date,myVector[[1]][1])
    time <- c(time, myVector[[1]][2])
    gActivePower <- c(gActivePower, as.numeric(myVector[[1]][3]))
    gReactivePower <- c(gReactivePower, as.numeric(myVector[[1]][4]))
    voltage <- c(voltage, as.numeric(myVector[[1]][5]))
    gIntensity <- c(gIntensity, as.numeric(myVector[[1]][6]))
    subMetering1 <- c(subMetering1, as.numeric(myVector[[1]][7]))
    subMetering2 <- c(subMetering2, as.numeric(myVector[[1]][8]))
    subMetering3 <- c(subMetering3, as.numeric(myVector[[1]][9]))
  }
} 
close(con)

df1 <- data.frame(date, time, gActivePower, gReactivePower, voltage, gIntensity, subMetering1, subMetering2, subMetering3)

#plot3
par(mfrow=c(1,1))
plot(contDTime, df1[,7], type="l", xlab="", ylab="Energy sub metering")
points(contDTime, df1[,8], type="l", col="red")
points(contDTime, df1[,9], type="l", col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=1, col=c("black", "red", "blue"))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()