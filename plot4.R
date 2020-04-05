## load libraries needed for the analysis. Set your working directory accordingly.  

library(reshape2)
library(lubridate)
library(tidyverse)
library(gridExtra)



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




## Global Active Power as a function of Date/Time
p1 <- qplot(DateTime, Global_active_power,
               data = HousePowFil1, geom = "line", 
               xlab = "Date and Time",
               ylab="Global Active Power")

## Voltage as a function of Date/Time
p2 <- qplot(DateTime, Voltage,
               data = HousePowFil1, geom = "line", 
               xlab = "Date and Time",
               ylab="Voltage")


## Multi-Variable line plot
p3 <- ggplot(HousePowFil1) + geom_line(aes(x=DateTime, y=Kitchen, color = "Kitchen"))+
        geom_line(aes(x=DateTime, y=Laundry_room, color = "Laundry Room"))+
        geom_line(aes(x=DateTime, y=Water_heater_AC, color = "Water Heater/AC"))+
        labs(x = "Date & Time", y = "Energy sub metering")+
        theme(legend.justification = c(1, 1), 
              legend.position = c(1, 1), legend.title = element_blank())

## Global Reactive Power as a function of Date/Time
p4 <- qplot(DateTime, Global_reactive_power,
               data = HousePowFil1, geom = "line", 
               xlab = "Date and Time",
               ylab="Global Reactive Power")

grid.arrange(p1, p2, p3, p4, ncol=2, nrow=2)
g<-arrangeGrob(p1,p2,p3,p4, ncol=2, nrow = 2)

ggsave("plot4.png", width = 8, height = 6, dpi = 600, g)

