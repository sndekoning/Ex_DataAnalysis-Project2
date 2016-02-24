if(!file.exists("./data")){dir.create("./data")
    
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip" 
download.file(file_url, "./data/PAdata.zip")
unzip("./data/PAdata.zip", exdir = "./data")
}

require(dplyr)

sclasscode <- tbl_df(readRDS("./data/Source_Classification_Code.rds"))
pm25 <- tbl_df(readRDS("./data/summarySCC_Pm25.rds"))