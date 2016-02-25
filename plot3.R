## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008?
## Use the ggplot2 plotting system to make a plot answer this question.
require(dplyr)
require(ggplot2)

if(!file.exists("./data")){dir.create("./data")
    
    file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip" 
    download.file(file_url, "./data/PAdata.zip")
    unzip("./data/PAdata.zip", exdir = "./data")
}

sclasscode <- tbl_df(readRDS("./data/Source_Classification_Code.rds"))
pm25 <- tbl_df(readRDS("./data/summarySCC_Pm25.rds"))


pm25xbalt <- pm25 %>%
    filter(fips == "24510")

names(pm25xbalt) <- tolower(names(pm25xbalt))

png(filename = "plot3.png", width = 500, height = 500)
p <- ggplot(data = pm25xbalt, aes(x = type, y= emissions, fill = type))
p + geom_bar(stat = "identity") + 
    facet_grid(.~year) +
    ggtitle("PM2.5 Emissions per type in Baltimore") +
    theme(axis.text.x = element_blank()) + 
    xlab("") +
    ylab("Emissions PM2.5 in tonnes")

dev.off()