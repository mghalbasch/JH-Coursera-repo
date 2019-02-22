# This script creates a plot showing total PM2.5 emissions for the
# years 1999, 2002, 2005, and 2008 in Baltimore, Maryland.
library(dplyr)

# First we load in the data:

summary_filename <- "./data/summarySCC_PM25.rds"
scc_filename <- "./data/Source_Classification_Code.rds"

NEI <- readRDS(summary_filename)
SCC <- readRDS(scc_filename)

# Now we select for only Baltimore (fips = 24510), and calculate
# the total emissions by year

NEI %>% filter(fips == "24510") %>% group_by(year) %>%
  summarise(total = sum(Emissions)) -> baltimore_totals

# Now we make a simple plot of these values:
png(filename = "plot2.png")

plot(baltimore_totals$year, baltimore_totals$total,
     pch = 20,
     xlab = "Year",
     ylab = "Total Emissions (Tons)",
     main = "Yearly Emissions in Baltimore, MD")

# Add lines to make the trend more obvious
lines(baltimore_totals$year, baltimore_totals$total)

dev.off()

# The plot shows a downward trend over the 10-year period, but 
# with a spike in 2005.