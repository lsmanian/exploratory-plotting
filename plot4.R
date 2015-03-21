
#please setwd to directory containing exdata-data-NEI_data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(plyr)

#grep for the pattern coal, my interpretation of problem statement is "Combustion related coal", i have seen other people grep for  coal,lignite,combo etc
# get each set, intersect and subtract, even though it is left to interpretation, the goal of this exercise is to plot the data and do exploratory,
# so i am going ahead with my interpretation :)

coal <- SCC[grep("coal",tolower(SCC$EI.Sector)),]

# subset the rows which are having coal in EI.Sector column
all_coal <- subset(NEI,NEI$SCC %in% coal$SCC)
# summarise the emissions , ordered by Year
coal_yearly <- ddply(all_coal,~year,summarise,total=sum(Emissions))
png(filename='plot4.png',units='px')
plot(coal_yearly,xlab="Years",ylab="PM2.5 total",main="Toal Emissions from coal related Combustion in  US ",type='l')
dev.off()
