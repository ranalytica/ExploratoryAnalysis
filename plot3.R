## load libraries needed for the analysis.  Set your working directory accordingly

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

## Using ggplot 
plot3 <- ggplot(HousePowFil1)
plot3 + geom_line(aes(x=DateTime, y=Kitchen, color = "Kitchen"))+
        geom_line(aes(x=DateTime, y=Laundry_room, color = "Laundry Room"))+
        geom_line(aes(x=DateTime, y=Water_heater_AC, color = "Water Heater/AC"))+
        labs(x = "Date & Time", y = "Energy sub metering")+
        theme(legend.justification = c(1, 1), 
                legend.position = c(1, 1), legend.title = element_blank())

## ggsave image to png format
ggsave("plot3.png")



