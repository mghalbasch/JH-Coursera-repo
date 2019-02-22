# This script creates a plot showing total PM2.5 emissions for the
# years 1999, 2002, 2005, and 2008 from motor vehicle related sources.
# We compare Baltimore to Los Angeles.

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

NEI %>% filter(SCC %in% good_SCCs) -> vehicle_NEI

# Now we want to compare Baltimore (fips = 24510) to LA (fips = 06037)
# We select these two fips values and create a new label for them:

vehicle_NEI %>% filter(fips == "24510" | fips == "06037") %>%
  mutate(city = ifelse(fips == "24510", 
                       yes = "Baltimore", 
                       no = "Los Angeles")) %>%
  group_by(year, city) %>%
  summarise(total = sum(Emissions)) %>%
  mutate(log_totals = log10(total)) -> city_vehicle_emissions

# Now we plot these emissions over the 10-year-period:
png(filename = "plot6.png")

ggplot(city_vehicle_emissions, aes(x = year, y=log_totals)) +
  geom_point() +
  geom_line() +
  theme_minimal() +
  xlab("Year") +
  ylab("log(Motor Vehicle Emissions in Tons)") +
  facet_grid(.~city)

dev.off()


# The plot shows that relative to its initial value in 1999, Baltimore
# has achieved a greater (percentage) decrease in emissions, but Los
# Angeles County has reduced its emissions by a larger overall value,
# since its totals are so much larger.

# We have plotted these changes on a log scale to see the Baltimore
# change more easily.