#please setwd to directory containing exdata-data-NEI_data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(plyr)
#summarise the Emissions for all types in NEI data and save with years as x and total as y
yearly_PM <- ddply(NEI,~year,summarise,total=sum(Emissions))
# base plot x,y with Years as 'x' and Total emissions from PM2.5 as y
png(filename='plot1.png',units='px')
plot(yearly_PM,xlab="Years",ylab="Total emission from PM2.5",type='l')
dev.off()