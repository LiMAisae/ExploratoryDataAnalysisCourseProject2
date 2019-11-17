NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 1
year<-c(1999,2002,2005,2008)
pm_by_year <- split(NEI$Emissions, NEI$year)
totalpm<- sapply(pm_by_year, sum)
plot(year,totalpm,type="b",col="red", lwd=2, xlab = "Year", ylab="Total pm2.5 emissions", main = "Total pm2.5 emissions from 1999 to 2008")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()