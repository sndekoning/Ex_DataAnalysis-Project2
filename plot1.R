## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from
## all sources for each of the years 1999, 2002, 2005, and 2008.

source("getdata.R")

totpm25 <- pm25 %>%
    group_by(year) %>%
    summarise(emissions = sum(Emissions)) %>%
    mutate(emissions = emissions / 1000)

x <- totpm25$year
y <- totpm25$emissions

png(filename = "plot1.png", width = 500, height = 500)
plot(x, y,
     type = "l", 
     main = "Total PM2.5 Emission per Year",
     xlab ="Year",
     ylab = "PM2.5 in tonnes x 1000")

dev.off()