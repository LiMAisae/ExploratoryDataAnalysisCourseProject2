NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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