setwd("~/Miscellaneous/Coursera/Exploratory-Data-Analysis/Project-1")

#------------------------------------------------------------------------------
# UNZIP AND LOAD DATA
#------------------------------------------------------------------------------
# Download zip file
zipFileName <- "exdata-data-household_power_consumption.zip"
rawDataFileName <- 'household_power_consumption.txt'
if(!file.exists(rawDataFileName)){
  unzip(zipFileName)
}

data <- read.table(rawDataFileName, header=TRUE, sep=';',
                   colClasses = rep("character", 9))

# Convert "Date" column to POSIX format
data$Date <- as.Date(data$Date, "%d/%m/%Y")
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# FILTER DATA FROM 2007-02-01 TO 2007-02-02
#------------------------------------------------------------------------------
subdata <- data[(data$Date >= as.Date("2007-02-01") & 
                data$Date <= as.Date("2007-02-02")), ]

# Add DateTime column, class = POSIX
subdata$Date <- as.character(subdata$Date)
subdata$DateTime <- strptime(paste(subdata$Date, subdata$Time), 
                             format="%Y-%m-%d %H:%M:%S")
# Replace "?" characters with NAs
subdata[,3:9] <- sapply(subdata[,3:9], function(x) ifelse(x=="?", "NA", x))
# Convert column types to numeric
subdata[,3:9] <- sapply(subdata[,3:9], function(x) as.numeric(as.character(x)))
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# CREATE PLOT plot2.png
#------------------------------------------------------------------------------
png(filename="plot2.png", width=480, height=480)
plot(subdata$DateTime, subdata$Global_active_power, type="l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
#------------------------------------------------------------------------------
