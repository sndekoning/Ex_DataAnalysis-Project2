## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
## vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

require(dplyr)
require(ggplot2)

if(!file.exists("./data")){dir.create("./data")
    
    file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip" 
    download.file(file_url, "./data/PAdata.zip")
    unzip("./data/PAdata.zip", exdir = "./data")
}

sclasscode <- tbl_df(readRDS("./data/Source_Classification_Code.rds"))
pm25 <- tbl_df(readRDS("./data/summarySCC_Pm25.rds"))

completepm25 <- right_join(pm25, sclasscode, by = "SCC")

## Getting totals of Baltimore
mobile_balt <- completepm25 %>%
    filter(EI.Sector = grepl("Mobile", completepm25$EI.Sector)) %>%
    filter(fips == "24510") %>%
    filter(!is.na(year))

names(mobile_balt) <- tolower(names(mobile_balt))

totmobile_balt <- mobile_balt %>%
    group_by(year) %>%
    summarise(emissions = sum(emissions)) %>%
    mutate(fips = "24510")

## Getting totals of LA
mobile_la <- completepm25 %>%
    filter(EI.Sector = grepl("Mobile", completepm25$EI.Sector)) %>%
    filter(fips == "06037") %>%
    filter(!is.na(year))

names(mobile_la) <- tolower(names(mobile_la))

totmobile_la <- mobile_la %>%
    group_by(year) %>%
    summarise(emissions = sum(emissions)) %>%
    mutate(fips = "06037")

##Merging into one dataset
totmobile <- bind_rows(totmobile_la, totmobile_balt)

x <- totmobile$year
y <- totmobile$emissions

png(filename = "plot6.png", width = 500, height = 500)
p <- ggplot(totmobile, aes(x=x, y=y, fill = year))
p + geom_bar(stat = "identity", position = "dodge") +
    facet_grid(.~fips) +
    ggtitle("PM2.5 Emissions per type in Baltimore and Los Angeles") + 
    theme(axis.text.x = element_blank()) + 
    xlab("") +
    ylab("Emissions PM2.5 in tonnes")
dev.off()