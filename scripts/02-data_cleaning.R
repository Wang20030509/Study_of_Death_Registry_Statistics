#### Preamble ####
# Purpose: Cleans the raw marriage data into an analysis dataset
# Author: Doran Wang
# Date: 23 September 2024
# Contact: doran.wang@mail.utoronto.ca 
# License: MIT
# Pre-requisites: Need to download the data


#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####
raw_data <- read_csv("Sta304-Term-Paper-1/data/raw_data/raw_data.csv")

# Clean and process the data
cleaned_data <- 
  raw_data |> 
  janitor::clean_names() |>  # Clean column names to snake_case
  separate(col = time_period,  # Separate 'time_period' into 'year' and 'month'
           into = c("year", "month"),
           sep = "-") |> 
  mutate(date = lubridate::ymd(paste(year, month, "01", sep = "-")),  # Create a date column
         civic_centre = str_to_upper(civic_centre),  # Convert civic centre names to uppercase
         place_of_death = str_to_title(place_of_death))  # Convert place of death to title case

#### Save data ####
# Save the cleaned data to the analysis folder
write_csv(cleaned_data, "C:/Users/User/Documents/Sta304-Term-Paper-1/data/analysis_data/analysis_data.csv")