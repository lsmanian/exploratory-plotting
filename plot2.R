#please setwd to directory containing exdata-data-NEI_data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subset NEI data for only zip code containing 24510 corresponding to Baltimore
baltimore <- subset(NEI,fips=="24510")
#summarise the total of Emissions (group by Year )
baltimore_PM <- ddply(baltimore,~year,summarise,total=sum(Emissions))


png(filename='plot2.png',units='px')
plot(baltimore_PM,xlab="Years",ylab="PM2.5 total",main="Toal Emissions in Baltimore ",type='l')
dev.off()