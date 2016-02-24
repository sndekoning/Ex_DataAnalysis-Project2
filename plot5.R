## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

source(getdata.R)

completepm25 <- right_join(pm25, sclasscode, by = "SCC")

mobile <- completepm25 %>%
    filter(EI.Sector = grepl("Mobile", completepm25$EI.Sector)) %>%
    filter(fips == "24510") %>%
    filter(!is.na(year))

names(mobile) <- tolower(names(mobile))

totmobile <- mobile %>%
    group_by(year) %>%
    summarise(emissions = sum(emissions)) 

x <- totmobile$year
y <- totmobile$emissions

png(filename = "plot5.png", width = 500, height = 500)
plot(x, y,
     type = "l", 
     main = "Motorized Vehicle PM2.5 Emission per Year",
     xlab ="Year",
     ylab = "PM2.5 in tonnes")

dev.off()