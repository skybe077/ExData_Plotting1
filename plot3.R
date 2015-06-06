
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


Plot3 <- function (asgn1) {
  #read data into environment using read.Asgn() first!  
  
  #Set PNG as the display driver
  png("plot3.png",pointsize = 12)
  
  #Multiple y plots
  #Do initial plot 
  plot (asgn1$dateTime, asgn1$Sub_metering_1, type="l",col="black", xlab="", ylab="Energy sub metering")
  lines (asgn1$dateTime, asgn1$Sub_metering_2,col="red")
  lines (asgn1$dateTime, asgn1$Sub_metering_3,col="blue")
  legend(x="topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"))
  
  #Turn off driver
  dev.off()
} 

#Running the code

asgn <-read.Asgn()
Plot3(asgn)