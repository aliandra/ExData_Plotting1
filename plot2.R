## plot2 of project 1 for Exploratory Data Analysis

## file path of data
power_file <- "household_power_consumption.txt"

## Cache data - The following if statement checks to see if data is already loaded into 
## global environment. If not, it will read data and assign to power_data.
## comment out next line once data has been loaded into global envir
power_data <- NULL
if(is.null(power_data)){
        ## return row number of where to start reading data, date Feb 1 2007
        start <- grep(as.character("1/2/2007"), readLines(power_file), fixed = T)[1] - 1
        ## return row number of where to end reading data, date Feb 2 2007
        end <- grep(as.character("3/2/2007"), readLines(power_file), fixed = T)[1] - 1
        ## return number of rows to read 
        diff <- end - start
        ## extract header from data
        header <- read.table(power_file, sep = ";", nrows = 1, header = T)
        
        ## read specified data into data frame called power_Data
        power_data <- read.table(power_file,
                                 sep = ";", 
                                 skip = start, 
                                 nrows = diff, 
                                 na.strings = "?")
        
        ## assign header to power_data
        colnames(power_data) <- colnames(header)
        
        ## combine date and time data and assign to new column of power_data
        power_data$new.col <- as.POSIXct(paste(power_data$Date, power_data$Time),
                                         format="%d/%m/%Y %H:%M:%S")
}

## plot Global Active Power for Date/Time
plot(power_data$new.col, 
     power_data$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

## copy plot to png file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()