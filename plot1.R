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

#plot1 histogram of global active power frequency
par(mfrow=c(1,1))
hist(df1[,3], col="red", ylim=c(0,1200), main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()