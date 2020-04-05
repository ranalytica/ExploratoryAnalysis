## load libraries needed for the analysis and set working directory

library(reshape2)
library(lubridate)
library(tidyverse)



## Download and unzip file to working directory

ZIPDATA <- "https://d396qusza40orc.cloudfront.net/
        exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(ZIPDATA, "./HousePow.zip")
unzip("./HousePow.zip", exdir = ".")

## Use read_delim under readr part of tidyverse package - data.frame format
HousePow <- read_delim("./household_power_consumption.txt", 
                       delim = ";", na="?", col_names = TRUE)

## dplyr and lubridate to make data Tidy
HousePowFil <- HousePow %>% filter(Date == "2/2/2007" | Date == "1/2/2007")
HousePowFil <- HousePowFil %>%  mutate(DateTime = paste(Date,Time, 
                sep  = " "), DateTime= dmy_hms(DateTime))
HousePowFil1 <- HousePowFil %>%  select(DateTime, Global_active_power:Sub_metering_3) %>% 
        rename(Kitchen = Sub_metering_1, Laundry_room = Sub_metering_2, 
               Water_heater_AC = Sub_metering_3) 


## Using qplot of the ggplot2 package
plot2 <- qplot(DateTime, Global_active_power,
               data = HousePowFil1, geom = "line", 
               xlab = "Date and Time",
               ylab="Global Active Power (kilowatts")
## Save image to png format
dev.copy(png, file="plot2.png")
print(plot2)
dev.off()
plot2















