setwd("~/data_study/ExploratoryDataAnalysis/CourseProject2/")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 1
year<-c(1999,2002,2005,2008)
pm_by_year <- split(NEI$Emissions, NEI$year)
totalpm<- sapply(pm_by_year, sum)
plot(year,totalpm,type="b",col="red", lwd=2, xlab = "Year", ylab="Total pm2.5 emissions", main = "Total pm2.5 emissions from 1999 to 2008")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
#Plot 2
year<-c(1999,2002,2005,2008)
pm_Baltimore <-subset(NEI, fips=="24510")
pm_by_year_Baltimore <- split(pm_Baltimore$Emissions, pm_Baltimore$year)
totalpm_Baltimore<-sapply(pm_by_year_Baltimore, sum)
plot(year,totalpm_Baltimore,type="b",col="red", lwd=2,xlab = "Year", ylab="Total pm2.5 emissions", main = "Total pm2.5 emissions from 1999 to 2008 in Baltimore")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
#Plot 3
library(ggplot2)
library(dplyr)
pm_Baltimore <-subset(NEI, fips=="24510")
by_year_type <- summarise(group_by(pm_Baltimore,year,type),emissions=sum(Emissions))
by_year_type$year = as.numeric(as.character(by_year_type$year))
ggplot(data=by_year_type, aes(x=year, y=emissions, col=type)) + geom_line() + geom_point() + ggtitle("Emissions in Baltimore City")
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()

#Plot 4
library(ggplot2)
library(dplyr)
coal_relatedMatches  <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
coal_related <- SCC[coal_relatedMatches, ]
pm_coal<-subset(NEI, SCC%in%coal_related$SCC)
by_year <- summarise(group_by(pm_coal,year),emissions=sum(Emissions))
ggplot(data=by_year, aes(x=year, y=emissions), label=emissions) + geom_line() + geom_point() + ggtitle("Coal combustion-related Emissions in US")
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
#Plot 5
library(ggplot2)
library(dplyr)

pm_veh<-subset(NEI, type == "ON-ROAD"& fips=="24510") 
by_year <- summarise(group_by(pm_veh,year),emissions=sum(Emissions))
ggplot(data=by_year, aes(x=year, y=emissions)) + geom_line() + geom_point() + ggtitle("Vehicle-related Emissions in Baltimore")
dev.copy(png, file="plot5.png", width=480, height=480)
dev.off()
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