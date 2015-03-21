#please setwd to directory containing exdata-data-NEI_data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# grep for "Vehicles in EI.Sector 
motor <- SCC[grep("vehicles",tolower(SCC$EI.Sector)),]
#subset row containing Vehicles in NEI data
vehicles_all <- subset(NEI,NEI$SCC %in% motor$SCC)
# Subset vehicles, by filtering with zip code of Baltimore
vehicles_baltimore <- subset(vehicles_all,fips=="24510")
#summarize by emissions, group by Year
library(plyr)
vehicles_baltimore_summary <- ddply(vehicles_baltimore,~year,summarise,total=sum(Emissions))
png(filename='plot5.png',units='px')
plot(vehicles_baltimore_summary,xlab="Years",ylab="PM2.5 total",main="Toal Emissions from Vehicles in Baltimore",type='l')
dev.off()
