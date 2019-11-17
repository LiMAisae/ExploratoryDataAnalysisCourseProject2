NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 6
library(ggplot2)
library(dplyr)
pm_veh<-subset(NEI, type == "ON-ROAD"& fips %in%c("24510" ,"06037"))
pm_veh$county<-""
pm_veh[pm_veh$fips=="24510",]$county<-"Baltimore"
pm_veh[pm_veh$fips=="06037",]$county<-"Los Angeles"
by_year <- summarise(group_by(pm_veh,year,county),emissions=sum(Emissions))
ggplot(data=by_year, aes(x=year, y=emissions, col=county, label=emissions)) + geom_line() + geom_point() + ggtitle("Vehicle-related Emissions in Baltimore and Los Angeles")
dev.copy(png, file="plot6.png", width=480, height=480)
dev.off()