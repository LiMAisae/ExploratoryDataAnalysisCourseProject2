NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 3
library(ggplot2)
library(dplyr)
pm_Baltimore <-subset(NEI, fips=="24510")
by_year_type <- summarise(group_by(pm_Baltimore,year,type),emissions=sum(Emissions))
by_year_type$year = as.numeric(as.character(by_year_type$year))
ggplot(data=by_year_type, aes(x=year, y=emissions, col=type)) + geom_line() + geom_point() + ggtitle("Emissions in Baltimore City")
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
