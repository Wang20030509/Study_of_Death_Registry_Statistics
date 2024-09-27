#### Preamble ####
# Purpose: Tests 
# Author: Doran Wang
# Date: 23 September 2024 
# Contact: doran.wang@mail.utoronto.ca 
# Pre-requisites: been access the "00-simulate_data.R", "01-download_data.R" and "02-data_cleaning.R"

#### Workspace setup ####
library(tidyverse)


#### Test data ####
data <- read_csv("data/raw_data/simulated_data.csv")
clean_data <- read_csv("data/analysis_data/cleaned_data.csv")

# Test for negative numbers.
# Pass: FALSE
data$DEATH_LICENSES |> min() <= 0
clean_data$death_licenses |> min() <= 0

# Test for NAs.
# Pass: FALSE
all(is.na(data$DEATH_LICENSES))
all(is.na(data$TIME_PERIOD))
all(is.na(clean_data$death_licenses))
all(is.na(clean_data$year))
all(is.na(clean_data$month))
all(is.na(clean_data$season))



# Test for civic centre are exclusively one of the 4 civic centres.
# Pass: TRUE
all(data$CIVIC_CENTRE %in% c("ET", "NY", "SC", "TO"))
all(clean_data$civic_centre %in% c("ET", "NY", "SC", "TO"))

# Test for PLACE_OF_DEATH are exclusively one of the 2 place.
# Pass: TRUE
all(data$PLACE_OF_DEATH %in% c("Toronto", "Outside City Limits"))
all(clean_data$place_of_death %in% c("Toronto", "Outside City Limits"))