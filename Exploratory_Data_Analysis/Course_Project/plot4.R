# This script creates a plot showing total PM2.5 emissions for the
# years 1999, 2002, 2005, and 2008 from coal-related sources.

library(dplyr)
library(ggplot2)

# First we load in the data:

summary_filename <- "./data/summarySCC_PM25.rds"
scc_filename <- "./data/Source_Classification_Code.rds"

NEI <- readRDS(summary_filename)
SCC <- readRDS(scc_filename)

# Now we need to look at the SCC file to find which source codes
# correspond to coal-related emissions.

SCC %>% filter(grepl("*[Cc]oal*",Short.Name)) -> coal_SCCs
good_SCCs <- coal_SCCs$SCC

# Now we filter our NEI set for these coal-related emissions:

NEI %>% filter(SCC %in% good_SCCs) %>% group_by(year) %>%
  summarise(total = sum(Emissions)/1e+03) -> coal_totals

# Now we plot these emissions over the 10-year-period:
png(filename = "plot4.png")

ggplot(coal_totals, aes(x = year, y=total)) +
  geom_point() +
  geom_line() +
  theme_minimal() +
  xlab("Year") +
  ylab("Coal Emissions (Thousands of Tons)") +
  labs(title = "Coal Emissions, 1999-2008")

dev.off()
         

# The plot shows that coal emissions have fallen significantly from
# 2005 to 2008, but were mostly flat (or very slightly decreasing)
# before that.