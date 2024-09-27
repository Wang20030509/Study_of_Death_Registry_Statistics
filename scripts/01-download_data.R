
#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Doran Wang
# Date: 23 September 2024
# Contact: doran.wang@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
install.packages("opendatatoronto")
install.packages("tidyverse")
library(opendatatoronto)
library(tidyverse)


#### Download data ####
# get package
package <- show_package("cba07a90-984b-42d2-9131-701c8c2a9788")

# get all resources for this package
resources <- list_package_resources("cba07a90-984b-42d2-9131-701c8c2a9788")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% 
  get_resource()

#### Save data ####
write_csv(data, "data/raw_data/death_registry.csv") 

