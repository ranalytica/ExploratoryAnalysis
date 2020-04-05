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
rm("HousePowFil")


## Plot1 in base R and copying image png format
plot1 <- hist(HousePowFil1$Global_active_power, col = "red",
              xlab = "Global Active Power (kilowatts)", 
              main = "Global Active Power", 
              breaks = 23,xlim=c(0,6.5), ylim=c(0,1300))
dev.copy(png, file="plot1.png")
print(plot1)
dev.off()
plot1
