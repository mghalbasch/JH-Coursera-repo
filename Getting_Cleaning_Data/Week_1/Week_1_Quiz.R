library(readxl)
library(XML)
library(RCurl)


data <- read.csv("getdata_data_ss06hid.csv")
# We can look at this data, but the code book provided is 
#much more informative

#head(data)

# We see that VAL contains the valuation of the home, coded into 24
# different categories

values <- data$VAL

# The category for values over 1,000,000 is 24, so we want just those
# rows with data$VAL = 24

one <- sum(values[values==24], na.rm=TRUE)/24

one
# There are 53 houses with valuations of over 1,000,000 dollars.

# Next we look at the FES variable.
head(data$FES)

# The FES variable encodes the status of the household, including
# the number of occupants, gender, and whether each is in the workforce.
# We find this via the codebook online.

# For number 3, we import an xlsx file. For this we use the 'readxl'
# package.
dat <- read_xlsx("getdata_data_DATA.gov_NGAP.xlsx", range="G18:O23")
three <- sum(dat$Zip*dat$Ext,na.rm=T)
three

# For number 4, we are reading in an xml file from the internet:
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
furl <- getURL(fileurl)
four_data <-xmlParse(furl)

# Now we have the xml tree from this file. We can process this using
# XMLSapply or XPathSApply
rootNode <- xmlRoot(four_data)
zips <- xpathSApply(rootNode, "//zipcode", xmlValue)
four <-length(zips[zips == 21231])
four

# For number 5, we are reading in data