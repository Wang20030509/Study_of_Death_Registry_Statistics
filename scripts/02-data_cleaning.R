
#### Preamble ####
# Purpose: Cleans the raw death registry data into an analysis datasets
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

# summarize the data
total_deaths <- aggregate(death_licenses ~ season + civic_centre, 
                          data = cleaned_data, sum)

# summarize the data of average of deaths by month
avg_deaths_by_month <- aggregate(death_licenses ~ month, data = cleaned_data, 
                                 FUN = mean) 

# summarize the data by place of death
place_summary <- aggregate(death_licenses ~ month + place_of_death, data = cleaned_data,
                           sum)

# summarize the data by civic centre
civic_summary <- aggregate(death_licenses ~ month + civic_centre, data = cleaned_data,
                           sum)

#### Save data ####
# Save the cleaned data to the analysis folder
write_csv(cleaned_data, "data/analysis_data/cleaned_data.csv")
write_csv(total_deaths, "data/analysis_data/summarize_data.csv")
write_csv(avg_deaths_by_month, "data/analysis_data/avg_deaths_by_month.csv")
write_csv(place_summary, "data/analysis_data/summarized_place_data.csv")
write_csv(civic_summary, "data/analysis_data/summarized_civic_data.csv")


