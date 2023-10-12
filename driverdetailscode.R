library(dplyr)
library(ggplot2)
library(tidyverse)

# Set the directory where your CSV files are located
directory_path <- "C:/Users/ASUS/Downloads/ArVr/arvr_a2/Datasets"

# List all CSV files in the directory
csv_files <- list.files(directory_path, pattern = ".csv$", full.names = TRUE)

# Use lapply to read all CSV files into a list of data frames
data_list <- lapply(csv_files, read.csv)




drivers <- data_list[[6]]

results <- data_list[[11]]

constructors <- data_list[[4]]

driver_standings <- data_list[[5]]
races <- data_list[[10]]

# Inner joint and keeping required columns with results and driverstandings for wins
joined <- inner_join(results, drivers, by = "driverId") %>%
  select(raceId, driverId, points, laps, milliseconds, constructorId, fastestLap, rank)

joined2 <- inner_join(joined, races, by = "raceId") %>%
  select(raceId, driverId, points, laps, milliseconds, constructorId, fastestLap, rank, year, round )

joined <- inner_join(joined2, constructors, by = "constructorId") %>%
  select(raceId, driverId, points, laps, milliseconds, constructorId, name, fastestLap, rank, year, round )

temp <- inner_join(joined, driver_standings, by = "driverId")
names(temp)
temp <- temp %>% select(driverId, points.x, laps, milliseconds, name, fastestLap, rank, year, round, position, wins )
temp$points.x


# Filter rows using dplyr
driver_filter <- temp %>%
  filter(driverId == 4)




# Constructor name:

x <- unique(driver_filter$name)
print(x)


cumulative_points <- driver_filter %>%
  group_by(driverId) %>%
  arrange(driverId) %>%
  mutate(CumulativePoints = cumsum(points.x))
cumulative_points

# Sort the data by driver and order of points
driver_filter2 <- driver_filter
driver_filter2 <- driver_filter2[order(driver_filter2$driverId, order(driver_filter2$points.x)), ]

# Calculate cumulative points
driver_filter2$CumulativePoints <- ave(driver_filter2$points.x, driver_filter2$driverId, FUN = cumsum)

