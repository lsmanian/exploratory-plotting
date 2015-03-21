#function passed to facet_grid to rename the default Labels
my_labeller<- function(var,val){
  #print(var)
  val <- as.character(val) 
  #print(val)
  if(var =="fips") {
    val[val =="06037"] <- "Los Angeles" 
    val[val == "24510"] <- "Baltimore"
  }
  #print(val)
  return (val)
}


#please setwd to directory containing exdata-data-NEI_data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# grep for "Vehicles in EI.Sector 
motor <- SCC[grep("vehicles",tolower(SCC$EI.Sector)),]
#subset row containing Vehicles in NEI data
vehicles_all <- subset(NEI,NEI$SCC %in% motor$SCC)
library(plyr)
#subset vehicles in LA and Baltimore
vehicles_balitmore_losangeles <- subset(vehicles_all,fips %in% c("24510","06037"))
# summarise the Emissions by Years/FIPS
vehicles_summary <- ddply(vehicles_balitmore_losangeles,.(year,fips),summarise,total=sum(Emissions))

png(filename='plot5.png',units='px')

#plot total pollution PM agains year and by facet - FIPS
gp <- ggplot(vehicles_summary,aes(x=year,y=total))+geom_line(aes(color=fips))+labs(title="LA/Baltimore Vehicular Emission Source")+labs(x="Years",y="total Vehicle emissions")
gp + facet_grid(. ~fips,labeller=my_labeller)+scale_color_discrete(labels=c("LosAngeles","Baltimore"))

dev.off()

