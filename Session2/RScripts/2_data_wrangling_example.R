# Session 2 ############################################################### Here
# I want to show a practical example using the time series data you gave me to 
# apply the functions we learned in the previous part. I try to comment briefly
# the steps I did here.

# Libraries ---------------------------------------------------------------
require(magrittr)
require(dplyr)
require(reshape2)
require(tidyr)
require(ggplot2)

# Load data ---------------------------------------------------------------
setwd("C:/Users/Christoph/Desktop/R Course")
obs_data <- read.csv("soilwater_obs.csv")
SD2C_sim <- read.csv("SD2C_sim.csv")
SD2C_grv <- read.csv("SD2C_gravi.csv")

# Edit data ---------------------------------------------------------------
SD2C_obs <- obs_data %>% # Use the data set obs_data
  select(date, depth, plot_09, plot_10, plot_12, plot_15) %>% # select the columns date, depth and plot 9, 10, 12, and 15
  rowwise %>% #all functions I apply from now on are applied rowwise
  mutate(date = as.Date(date, "%Y-%m-%d"), # date is converted to date format
         obs_mean = mean(c(plot_09, plot_10, plot_12, plot_15), na.rm = TRUE), # the mean value is calculated from the 4 plots
         obs_sd = sd(c(plot_09, plot_10, plot_12, plot_15), na.rm = TRUE), # standard deviation is calculated from the 4 plots
         n_samp = sum(!is.na(c(plot_09, plot_10, plot_12, plot_15))), # the number of plots where measurements were done is derived
         obs_se = obs_sd/sqrt(n_samp), # from sd and the number of samples the standard error is calculated
         obs_lw = obs_mean - obs_se, # lower boundary of error bar is calculated
         obs_up = obs_mean + obs_se) %>% # upper boundary of error bar is calculated
  select(-starts_with("plot")) # all columns that have "plot" in their headers are removed


SD2C_sim_reshp <- SD2C_sim %>% 
  melt(id = "date") %>% # the data is brought into the long format
  separate(variable, into = c("remove", "depth"), sep = "_") %>% # the new column variable holding e.g. "sim_5" is separated
  mutate(date = as.Date(date, "%d.%m.%Y"), # date is converted to date format
         depth = as.numeric(depth), # the new column depth is converted to numeric as the numbers were still text strings 
         sim = value*100) %>% # The water content values were converted to percentages
  select(-remove, -value) # columns remove and value are removed

# The exact same steps are done for the gravimetric data:

SD2C_grv_reshp <- SD2C_grv %>% 
  melt(id = "date") %>% 
  separate(variable, into = c("remove", "depth"), sep = "_") %>% 
  mutate(date = as.Date(date, "%d.%m.%Y"),
         depth = as.numeric(depth),
         grv = value*100) %>% 
  select(-remove, -value)
  
SD2C <- left_join(SD2C_sim_reshp, SD2C_obs) %>% # the simulation data and the observation data are joined (in this case by date and depth)
  left_join(SD2C_grv_reshp) %>% # the joined data set is joined with the gravimetric data set
  arrange(date) # the date is ordered by date


# Plotting results --------------------------------------------------------
# This again should only by a demonstration plot. More about plotting I will show in session 3
ggplot(SD2C) +
  geom_line(aes(x = date, y = sim)) + 
  geom_pointrange(aes(x = date, y = obs_mean, ymin = obs_lw, ymax = obs_up), col = "cadetblue") + 
  geom_point(aes(x = date, y = grv), col = "coral3", pch = 15) +
  facet_wrap(~depth, ncol = 3) 
  
