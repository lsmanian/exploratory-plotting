#please setwd to directory containing exdata-data-NEI_data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subset NEI data for only zip code containing 24510 corresponding to Baltimore
baltimore <- subset(NEI,fips=="24510")
#summarise the total of Emissions (group by Year and type)
baltimore_PM_type <- ddply(baltimore,.(year,type),summarise,total=sum(Emissions))
library(ggplot2)
#use ggplot to represent the total emission for a particular year with respect to type of EMission as facet
png(filename='plot3.png',units='px')
g <- ggplot(baltimore_PM_type,aes(year,total))
g+geom_line(aes(color=type))+facet_grid(.~type)+labs(title="Baltimore City,PM data")+labs(x="Years",y="total emissions from PM2.5")
dev.off()