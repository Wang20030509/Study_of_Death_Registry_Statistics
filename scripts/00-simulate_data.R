#### Preamble ####
# Purpose: Simulates the death registry statistics data
# Author: Doran Wang
# Date: 23 September 2024
# Contact: doran.wang@mail.utoronto.ca
# Pre-requisites: Access to the death_registry_statistics_data.csv


#### Workspace setup ####
library(tidyverse)
library(lubridate)


#### Simulate data ####

set.seed(509)

# Set seed for reproducibility
set.seed(123)

# Define the number of simulations
n <- 100

# Generate IDs
sim_id <- 1:n

# Define the date range
start_date <- as.Date("2011-01-01")
end_date <- as.Date("2024-08-01")

# Generate random dates between start_date and end_date
random_dates <- sample(seq.Date(from = start_date, to = end_date, by = "month"), n, replace = TRUE)
random_year_month <- format(random_dates, "%Y-%m")  # Format as "YYYY-MM"

# Define regions (e.g., civic centers) and places of death
regions <- c("ET", "NY", "SC", "TO")
places_of_death <- c("Toronto", "Outside City Limits")

# Simulate random regions and places of death
sim_regions <- sample(regions, n, replace = TRUE)
sim_places_of_death <- sample(places_of_death, n, replace = TRUE)

# Simulate death licenses using a Poisson distribution with lambda = 261.32
sim_death_licenses <- rpois(n, lambda = 261.32)

# Combine all data into a dataframe
sim_data <- data.frame(
  id = sim_id,
  TIME_PERIOD = random_year_month,
  CIVIC_CENTRE = sim_regions,
  PLACE_OF_DEATH = sim_places_of_death,
  DEATH_LICENSES = sim_death_licenses
)

#### Write_csv ####
write_csv(sim_data, file = "data/raw_data/simulated_data.csv")






