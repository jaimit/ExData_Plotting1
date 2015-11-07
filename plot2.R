# Load the data in R
###Open File interactively in R

dataPath<-file.choose();
data <- read.table(dataPath, header=TRUE, sep=";",stringsAsFactors=FALSE,dec=".")

### Remove all the puncuations from the variable names 
### Convert the variable names to lower case
varName<-tolower(gsub("[[:punct:]]", "", names(data)))
names(data)<-varName

### Conver the time variable from character to Time type using strptime()
### Convert the date variable from character to Date type
data$time<- strptime(paste(data$date, data$time, sep=" "), "%d/%m/%Y %H:%M:%S")
data$date<-as.Date(data$date,"%d/%m/%Y")

### Access the subset of the data from 2007-02-01 to 2007-02-02
smallData<-subset(data,(data$date>=as.Date("2007-02-01"))&(data$date<=as.Date("2007-02-02")))

### convert global active power to numeric value from character

png("plot2.png", width=480, height=480)
plot(smallData$time,as.numeric(smallData$globalactivepower),type="l",xlab = "",ylab="Global Active Power (kilowatts)")
dev.off()