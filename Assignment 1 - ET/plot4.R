
library(sqldf)


read.Asgn <- function () {
  #For a subset of a dataset with selection criteria
  # use SQL to get that info out
  
  fi <- file("assgn1.txt")
  
  asgn1 <- sqldf("select * from fi where date == '1/2/2007' OR date == '2/2/2007' ", file.format = list(header = TRUE, sep = ";"))  
  #Set Class to Date using strpTime because the initial combi creates a Character class
  dateTime <-strptime(paste(asgn1$Date, asgn1$Time), "%d/%m/%Y %H:%M:%S")
  asgn1<-cbind(asgn1[,-1:-2], dateTime)
  
  close(fi)
  
  return(asgn1)
} 

Plot4 <- function  (asgn1) {
  #read data into environment using read.Asgn() first!  
  
  #Set PNG as the display driver
  png("plot4.png",pointsize = 12)
  
  #Multiple types of plots in 1 layout
  
  #Prep layout display
  layout(matrix(c(1,2,3,4), nrow = 2, ncol = 2, byrow=TRUE))
  
  #layout1 : Active Power line graph / plot2
  plot (asgn1$dateTime, asgn1$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  #layout2 : voltage line graph
  plot (asgn1$dateTime, asgn1$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  #layout3 : submeter multi-line graph
  plot (asgn1$dateTime, asgn1$Sub_metering_1, type="l",col="gray", xlab="", ylab="Energy sub metering")
  lines (asgn1$dateTime, asgn1$Sub_metering_2,col="red")
  lines (asgn1$dateTime, asgn1$Sub_metering_3,col="blue")
  legend(x="topright", xjust=1, yjust = 0, c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=1, bty="n", col=c("gray","red","blue"))
  
  #layout4 : reactive power line graph  
  plot (asgn1$dateTime, asgn1$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  #Turn off driver
  dev.off()
}

#Running the code

asgn <-read.Asgn()
Plot4(asgn)