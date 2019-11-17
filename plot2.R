NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 2
year<-c(1999,2002,2005,2008)
pm_Baltimore <-subset(NEI, fips=="24510")
pm_by_year_Baltimore <- split(pm_Baltimore$Emissions, pm_Baltimore$year)
totalpm_Baltimore<-sapply(pm_by_year_Baltimore, sum)
plot(year,totalpm_Baltimore,type="b",col="red", lwd=2,xlab = "Year", ylab="Total pm2.5 emissions", main = "Total pm2.5 emissions from 1999 to 2008 in Baltimore")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()