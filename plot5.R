NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 5
library(ggplot2)
library(dplyr)

pm_veh<-subset(NEI, type == "ON-ROAD"& fips=="24510") 
by_year <- summarise(group_by(pm_veh,year),emissions=sum(Emissions))
ggplot(data=by_year, aes(x=year, y=emissions)) + geom_line() + geom_point() + ggtitle("Vehicle-related Emissions in Baltimore")
dev.copy(png, file="plot5.png", width=480, height=480)
dev.off()