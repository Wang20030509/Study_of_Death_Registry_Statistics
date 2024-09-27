
#### Preamble ####
# Purpose: Cleans the raw marriage data into an analysis dataset
# Author: Doran Wang
# Date: 23 September 2024
# Contact: doran.wang@mail.utoronto.ca 
# Pre-requisites: Need to download the data


#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####
raw_data <- read_csv("data/raw_data/death_registry.csv")

# Clean and process the data
cleaned_data <- 
  raw_data |> 
  janitor::clean_names() |>  # Clean column names to snake_case
  separate(col = time_period,  # Separate 'time_period' into 'year' and 'month'
           into = c("year", "month"),
           sep = "-",
           convert = TRUE) |>   # Convert year and month to integer
  mutate(civic_centre = str_to_upper(civic_centre),  # Convert civic centre names to uppercase
         place_of_death = str_to_title(place_of_death),  # Convert place of death to title case
         month = month.abb[month],
         season = case_when(  # Assign session based on month
           month %in% c("Mar", "Apr", "May") ~ "Spring",
           month %in% c("Jun", "Jul", "Aug") ~ "Summer",
           month %in% c("Sep", "Oct", "Nov") ~ "Fall",
           month %in% c("Dec", "Jan", "Feb") ~ "Winter",
           TRUE ~ NA_character_))  # Handle any unexpected values

#### Save data ####
# Save the cleaned data to the analysis folder
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
