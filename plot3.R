## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008?
## Use the ggplot2 plotting system to make a plot answer this question.

source("getdata.R")
require(ggplot2)

pm25xbalt <- pm25 %>%
    filter(fips == "24510") %>%

names(pm25xbalt) <- tolower(names(pm25xbalt))

png(filename = "plot3.png", width = 500, height = 500)
p <- ggplot(data = pm25xbalt, aes(x = type, y= emissions, fill = type))
p + geom_bar(stat = "identity") + 
    facet_grid(.~year) +
    ggtitle("PM2.5 Emissions per type in Baltimore") +
    theme(axis.text.x = element_blank()) + 
    xlab("")

dev.off()