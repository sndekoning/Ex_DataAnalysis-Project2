## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.
require(dplyr)

if(!file.exists("./data")){dir.create("./data")
    
    file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip" 
    download.file(file_url, "./data/PAdata.zip")
    unzip("./data/PAdata.zip", exdir = "./data")
}

sclasscode <- tbl_df(readRDS("./data/Source_Classification_Code.rds"))
pm25 <- tbl_df(readRDS("./data/summarySCC_Pm25.rds"))

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