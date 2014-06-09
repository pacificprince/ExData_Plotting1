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
# CREATE PLOT plot1.png
#------------------------------------------------------------------------------
png(filename="plot1.png", width=480, height=480)
hist(subdata$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")
dev.off()
#------------------------------------------------------------------------------

