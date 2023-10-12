library(dplyr)

# Set the directory where your CSV files are located
directory_path <- "C:/Users/ASUS/Downloads/ArVr/arvr_a2/Datasets"

# List all CSV files in the directory
csv_files <- list.files(directory_path, pattern = ".csv$", full.names = TRUE)

# Use lapply to read all CSV files into a list of data frames
data_list <- lapply(csv_files, read.csv)


circuitid <- data_list[[1]]
constructor_results <- data_list[[2]]
constructor_standings <- data_list[[3]]
constructors <- data_list[[4]]
driver_standings <- data_list[[5]]
drivers <- data_list[[6]]
lap_times <- data_list[[7]]
pit_stops <- data_list[[8]]
qualifying <- data_list[[9]]
races <- data_list[[10]]
results <- data_list[[11]]
seasons <- data_list[[12]]
sprint_results <- data_list[[13]]
status <- data_list[[14]]


summary(pit_stops)

plot(year~duration, data = joined_df)




# Inner join based on the 'ID' column
joined_df <- inner_join(races, pit_stops, by = "raceId")

library(ggplot2)


# Create a scatterplot using ggplot2
ggplot(joined_df, aes(x = duration, y = year)) +
  geom_point(shape = 16, color = "blue") +
  labs(title = "Scatterplot Example", x = "X-axis label", y = "Y-axis label")

# 'joined_df' will contain the joined data

# Inner join based on the 'ID' column
joined_df <- inner_join(races, lap_times, by = "raceId") %>% select(raceId, year, circuitId, milliseconds)


# Filter rows using dplyr
filtered_data <- joined_df %>%
  filter(circuitId == 14)



# Sort the data within each year
sorted_data <- filtered_data %>%
  group_by(year) %>%
  summarise(fastest_lap = min(milliseconds))

# Create a scatterplot using ggplot2
ggplot(sorted_data, aes(x = year, y = fastest_lap)) +
  geom_point(shape = 16, color = "blue") +
  labs(title = "Scatterplot Example", x = "X-axis label", y = "Y-axis label")

# Create a line plot using ggplot2
ggplot(sorted_data, aes(year, fastest_lap)) +
  geom_line(color = "blue", size = 1) +
  labs(title = "Line Plot Example", x = "year", y = "fastest lap")


###############################################################
joined <- inner_join(results, drivers, by = "driverId") %>% select(raceId, driverId, points, laps, milliseconds, constructorId, fastestLap, rank)

joined <- inner_join(joined, races, by = "raceId") %>% select(raceId, driverId, points, laps, milliseconds, constructorId, fastestLap, rank, year, round, )

# Filter rows using dplyr
filtered_data <- joined %>%
  filter(driverId == 1)

filtered_data2 <- joined %>% 
  filter(driverId == 3)

