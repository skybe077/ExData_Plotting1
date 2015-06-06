
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

Plot1 <- function (asgn1) {
  #read data into environment using read.Asgn() first!  
  
  #Set PNG as the display driver
  png("plot1.png",pointsize = 12)
  
  # a red histogram chart for frequnecy vs active power
  hist(asgn1$Global_active_power, ylim=c(0, 1200),  col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
  
  
  #Turn off driver
  dev.off()
}

#Running the code

asgn <-read.Asgn()
Plot1(asgn)