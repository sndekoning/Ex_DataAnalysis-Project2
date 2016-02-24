## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

source("getdata.R")

completepm25 <- right_join(pm25, sclasscode, by = "SCC")

coal <- completepm25 %>%
    filter(Short.Name = grepl("Coal", completepm25$Short.Name)) %>%
    filter(!is.na(year))

names(coal) <- tolower(names(coal))

totcoal <- coal %>%
    group_by(year) %>%
    summarise(emissions = sum(emissions)) 

x <- totcoal$year
y <- totcoal$emissions

png(filename = "plot4.png", width = 500, height = 500)
plot(x, y,
     type = "l", 
     main = "Coal PM2.5 Emission per Year",
     xlab ="Year",
     ylab = "PM2.5 in tonnes")

dev.off()