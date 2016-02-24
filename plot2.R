## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

source("getdata.R")

pm25xbalt <- pm25 %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarise(emissions = sum(Emissions))
   

x <- pm25xbalt$year
y <- pm25xbalt$emissions

png(filename = "plot2.png", width = 500, height = 500)
plot(x, y,
     type = "l",
     main = "Total PM2.5 emission per year in Baltimore",
     xlab = "Year",
     ylab = "PM2.5 in tonnes")
dev.off()