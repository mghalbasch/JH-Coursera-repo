# This script creates a plot showing total PM2.5 emissions for the
# years 1999, 2002, 2005, and 2008 from motor vehicle related sources.
# We look specifically at Baltimore, MD.

library(dplyr)
library(ggplot2)

# First we load in the data:

summary_filename <- "./data/summarySCC_PM25.rds"
scc_filename <- "./data/Source_Classification_Code.rds"

NEI <- readRDS(summary_filename)
SCC <- readRDS(scc_filename)

# Now we need to look at the SCC file to find which source codes
# correspond to motor vehicle sources - we choose both 'motor' and
# 'vehicle' to capture this, as e.g. motorcycles are not captured
# by 'vehicle' and 'diesel vehicle' is not captured by 'motor'

SCC %>% filter(grepl("*[Mm]otor*",Short.Name) |
                 grepl("*[Vv]ehicle*", Short.Name)) -> motor_SCCs
good_SCCs <- motor_SCCs$SCC

# Now we filter our NEI set for these motor vehicle emissions
# specifically in Baltimore, MD (fips == "24510")

NEI %>% filter(SCC %in% good_SCCs & fips == "24510") %>% 
  group_by(year) %>%
  summarise(total = sum(Emissions)) -> vehicle_totals

# Now we plot these emissions over the 10-year-period:
png(filename = "plot5.png")

ggplot(vehicle_totals, aes(x = year, y=total)) +
  geom_point() +
  geom_line() +
  theme_minimal() +
  xlab("Year") +
  ylab("Motor Vehicle Emissions (Tons)") +
  labs(title = "Motor Vehicle Emissions in Baltimore, 1999-2008")

dev.off()


# The plot shows that vehicle emissions have dramatically decreased in
# Baltimore since 1999, with a sharp drop by 2002 and slower decline
# after that.