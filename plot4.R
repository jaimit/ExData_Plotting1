# Load the data in R
###Open File interactively in R

dataPath<-file.choose();
data <- read.table(dataPath, header=TRUE, sep=";",stringsAsFactors=FALSE,dec=".")

### Remove all the puncuations from the variable names 
### Convert the variable names to lower case
varName<-tolower(gsub("[[:punct:]]", "", names(data)));
names(data)<-varName;

### Conver the time variable from character to Time type using strptime()
### Convert the date variable from character to Date type
data$time<- strptime(paste(data$date, data$time, sep=" "), "%d/%m/%Y %H:%M:%S");
data$date<-as.Date(data$date,"%d/%m/%Y");

### Access the subset of the data from 2007-02-01 to 2007-02-02
smallData<-subset(data,(data$date>=as.Date("2007-02-01"))&(data$date<=as.Date("2007-02-02")))

### convert all the columns except data and time to numeric values

smallData[,3:9]<-lapply(smallData[,3:9], as.numeric);


### Plot the data 

png("plot4.png", width=480, height=480)
## Make a 2 row by 2 column plot
par(mfcol=c(2,2))


plot(smallData$time,smallData$globalactivepower,type="l",xlab = "",ylab="Global Active Power (kilowatts)")


plot(smallData$time, smallData$submetering1, type="l", ylab="Energy Submetering", xlab="")
lines(smallData$time, smallData$submetering2, type="l", col="red")
lines(smallData$time, smallData$submetering3, type="l", col="blue")
legend("topright", names(smallData[7:9]), lty=1,bty="n", col=c("black", "red", "blue"))


plot(smallData$time, smallData$voltage, type="l", xlab="datetime", ylab="Voltage")

plot(smallData$time, smallData$globalreactivepower, type="l", xlab="datetime", ylab="Global_reactive_power")


dev.off()