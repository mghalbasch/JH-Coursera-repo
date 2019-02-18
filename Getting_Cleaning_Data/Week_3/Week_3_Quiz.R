library(Hmisc)
library(dplyr)
library(jpeg)
library(readxl)

# Question 1 asks about community data from 2006 in Idaho.
# We download this file and analyze it below.

q1_url <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
q1_data <- as.data.frame(read.csv(q1_url))

# Now we want to create a logical vector that finds households with
# more than 10 acres who sold more than $10,000 of agricultural
# products. Looking at the code book, we see that these conditions
# correspond to 'ACR' = 3 and 'AGS' = 6.

agricultureLogical <- q1_data$ACR==3 & q1_data$AGS == 6
which(agricultureLogical)

# To test that this works, we can check those three rows in our
# data frame for the correct values.

q1_data[c(125,238,262),c("ACR","AGS")]

# Question 2 requires that we download a jpeg image for analysis.
# We read this file in through the readJPEG function in the JPEG package
# We will download the file from the internet into the 'data' folder
# in this directory, and create that folder if it does not exist.

if(!file.exists("./data")){dir.create("./data")}
q2_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(q2_url, destfile="./data/q2_img.jpg", method="curl")
q2_img <- readJPEG("./data/q2_img.jpg", native=TRUE)

# Now we can calculate the quantiles of this numerical vector
# representing the jpeg image. We need the 30th and 80th percentiles.
quantile(q2_img, probs=c(0.3,0.8))

# Questions 3-5 require GDP and educational data. We will read these
# from the internet.
q3_gdp_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(q3_gdp_url, destfile="./data/q3_gdp.csv", method="curl")
q3_ed_url <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
q3_gdp <- read.csv("./data/q3_gdp.csv", skip=4, nrows=190,
                   col.names=c("CountryCode","Ranking","V",
                               "Economy","Millions","V1",
                               "V2","V3","V4","V5"))
q3_ed <- read.csv(q3_ed_url)

# Now for Q3 we need to match this data according to the country
# shortcode, then sort it by descending GDP rank.

q3_gdp <- select(q3_gdp, CountryCode, Ranking, Economy, Millions)
q3_combined <- merge(q3_gdp,q3_ed)
q3_combined %>% arrange(desc(Ranking)) %>% head(13)
nrow(q3_combined)


# Question 4 asks us to compute the average GDP ranking for the
# "High income:OCED" and "High income: nonOCED" groups.
q3_combined %>% group_by(Income.Group) %>% 
  summarise(avg_rank = mean(Ranking))


# Question 5 asks that we split the GDP ranking into 5 quantile
# groups, and make a table against Income.Group.
q3_combined %>% mutate(rank_quantile = cut2(Ranking, g=5)) %>%
  select(rank_quantile, Income.Group) %>% table
