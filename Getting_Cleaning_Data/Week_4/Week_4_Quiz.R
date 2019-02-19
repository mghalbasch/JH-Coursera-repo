library(dplyr)
library(quantmod)

# Question 1 asks to look at the Idaho American Community Survey data.
# We read this data in and apply strsplit()

q1_url <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
q1_data <- read.csv(q1_url)
q1_split <- strsplit(names(q1_data),"wgtp")
q1_split[[123]]


# Question 2 refers again to the GDP data from the previous week.
# We will load this data in as character vectors for analysis.

q2_url <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")
q2_data <- read.csv(q2_url, colClasses = "character",
                    skip=4, nrows = 190,
                    col.names=c("CountryCode","Ranking","V","Country",
                               "Millions","V1","V2","V3","V4","V5"))
q2_data <- select(q2_data, CountryCode, Ranking, Country, Millions)

# Now we will select just the Millions row for analysis here, but we
# need to remove the commas. We will use 'gsub' for this.

q2_data %>% mutate(Millions = as.numeric(gsub("[,| ]","",Millions))) %>%
  select(Millions) %>% summarise(avg = mean(Millions))

# q3 asks how to determine whether a country begins with "United".

q3 <- grep("^United",q2_data$Country)
q3

# q4 asks that we combine the q2 data with educational data again from
# last week. We load it in here.

q4_url <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
q4_data <- read.csv(q4_url)
names(q4_data)
q4_combined <- merge(q2_data,q4_data, by="CountryCode")
head(q4_combined)

# Looking at the data we see that the end of fiscal year is encoded in
# 'Special.Notes'. We will filter these notes for inclusion of the
# phrase: 'Fiscal year end: June 30'

Special_Notes <- q4_combined$Special.Notes
Special_Notes[grepl("*Fiscal year end: June 30*",Special_Notes)]

# Question 5 requires the package 'quantmod' to download stock data.
# We will be looking at Amazon stock data in particular

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
head(sampleTimes)

# Looking at this data, we see a simple data format of year-month-day.
# We want all the data from 2012, and then mondays in 2012.
# We can do this by casting these dates as POSIXlt dates.

times <- as.POSIXlt(sampleTimes)
length(times[times$year == 112])
length(times[times$year == 112 & times$wday == 1])
