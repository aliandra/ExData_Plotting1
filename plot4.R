## plot4 of project 1 for Exploratory Data Analysis

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
par(mfrow = c(2, 2))
with (power_data, {
      ## plot Global Active Power for Date/Time
      plot(power_data$new.col, 
           power_data$Global_active_power,
           type = "l",
           ylab = "Global Active Power",
           xlab = "")
      
      ## plot voltage for Date/Time
      plot(power_data$new.col, power_data$Voltage,
           type = "l",
           ylab = "Voltage",
           xlab = "datetime")
      
      ## plot Sub Metering 1, 2, and 3 for Date/Time
      plot(power_data$new.col, power_data$Sub_metering_1, type = "l",
           ylab = "Energy sub metering", xlab = "")
      lines(power_data$new.col, power_data$Sub_metering_2, col = "red")
      lines(power_data$new.col, power_data$Sub_metering_3, col = "blue")
      ## Add legend
      legend("topright",
             col = c("black", "red", "blue"),
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
             cex = 0.5,
             text.width = strwidth("Sub_met_3"),
             yjust = 1,
             lwd = 1,
             y.intersp=0.25,
             bty = "n"
             )
      ## plot Global Reactive Power for Date/Time
      plot(power_data$new.col,
           power_data$Global_reactive_power,
           type = "l",
           xlab = "datetime",
           ylab = "Global_reactive_power"
           )
      })

## copy plot to png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()