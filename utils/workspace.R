# SETUP -----------------------------------------------------------------------
library(fredr)
library(gridExtra)
library(tidyverse)

source("./config.R")
source("./pltlib.R")

fredr_set_key(FRED_KEY)

# TEST ------------------------------------------------------------------------

prime_age_emp        <- "LREM25TTUSM156S" # level and pct change
prime_age_male_emp   <- "LREM25MAUSM156S" # level and pct change 

d <- c(prime_age_emp, prime_age_male_emp)
labels <- c("All", "Males")
names(labels) <- d

start_date <- as.Date("1990-01-01")
today <- as.Date(Sys.time())
short_date <- today - (365*5)
unit_change <- "pc1"
unit_level <- "lin"

recession_dates <- get_recessions(start_date=start_date)
data <- get_data(d, start_date, unit_change)

plot <- plt(d, start_date, unit_change, recession_dates, "Percent", labels=labels)
