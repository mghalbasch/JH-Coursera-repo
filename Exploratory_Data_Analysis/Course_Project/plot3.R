# This script creates a plot showing total PM2.5 emissions for the
# years 1999, 2002, 2005, and 2008 in Baltimore, Maryland, according
# to the type of emission.

library(dplyr)
library(ggplot2)

# First we load in the data:

summary_filename <- "./data/summarySCC_PM25.rds"
scc_filename <- "./data/Source_Classification_Code.rds"

NEI <- readRDS(summary_filename)
SCC <- readRDS(scc_filename)

# Now we select for only Baltimore (fips = 24510), and calculate the
# total emissions by year and type.

NEI %>% filter(fips == "24510") %>% group_by(year, type) %>%
  summarise(total = sum(Emissions)) -> baltimore_totals_type

# Now we use the ggplot2 package to create a facet grid of
# these emissions by type:
png(filename = "plot3.png")

ggplot(baltimore_totals_type, aes(x=year, y=total)) +
  geom_point() +
  geom_line() +
  facet_grid(.~type) +
  ylab("Total Emissions (Tons)") +
  xlab("Year") +
  theme_minimal()

dev.off()

# The plot shows that emissions of type "Point" have been flat or
# increasing since 1999, but other sources have been decreasing.
