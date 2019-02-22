# This script creates a plot showing total PM2.5 emissions for the
# years 1999, 2002, 2005, and 2008.

library(dplyr)

# First we load in the data:

summary_filename <- "./data/summarySCC_PM25.rds"
scc_filename <- "./data/Source_Classification_Code.rds"

NEI <- readRDS(summary_filename)
SCC <- readRDS(scc_filename)

# Now we collect the total emissions by year, from every source:
NEI %>% group_by(year) %>% 
  summarise(total = sum(Emissions)/1e+06) -> year_totals

# Now we plot this simple summary by year in the base system:
png(filename = "plot1.png")

plot(year_totals$year, year_totals$total, pch=20,
     xlab = "Year",
     ylab = "Total Emissions (Millions of Tons)",
     main = "Yearly Emissions")

# Add a simple line to show the trend a little more clearly
lines(year_totals$year, year_totals$total)

dev.off()

# The plot suggests that total emissions have indeed decreased from
# 1999 to 2008
