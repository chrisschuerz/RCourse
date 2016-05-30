# Session 2 ###############################################################

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
SD2C_obs <- obs_data %>% 
  select(date, depth, plot_09, plot_10, plot_12, plot_15) %>% 
  rowwise %>% 
  mutate(date = as.Date(date, "%Y-%m-%d"),
         obs_mean = mean(c(plot_09, plot_10, plot_12, plot_15), na.rm = TRUE),
         obs_sd = sd(c(plot_09, plot_10, plot_12, plot_15), na.rm = TRUE),
         n_samp = sum(!is.na(c(plot_09, plot_10, plot_12, plot_15))),
         obs_se = obs_sd/sqrt(n_samp),
         obs_lw = obs_mean - obs_se,
         obs_up = obs_mean + obs_se) %>% 
  select(-starts_with("plot"))


SD2C_sim_reshp <- SD2C_sim %>% 
  melt(id = "date") %>% 
  separate(variable, into = c("remove", "depth"), sep = "_") %>% 
  mutate(date = as.Date(date, "%d.%m.%Y"),
         depth = as.numeric(depth),
         sim = value*100) %>% 
  select(-remove, -value)

SD2C_grv_reshp <- SD2C_grv %>% 
  melt(id = "date") %>% 
  separate(variable, into = c("remove", "depth"), sep = "_") %>% 
  mutate(date = as.Date(date, "%d.%m.%Y"),
         depth = as.numeric(depth),
         grv = value*100) %>% 
  select(-remove, -value)
  
SD2C <- left_join(SD2C_sim_reshp, SD2C_obs) %>% 
  left_join(SD2C_grv_reshp) %>% 
  arrange(date)


# Plotting results --------------------------------------------------------
ggplot(SD2C) +
  geom_line(aes(x = date, y = sim)) + 
  geom_pointrange(aes(x = date, y = obs_mean, ymin = obs_lw, ymax = obs_up), col = "cadetblue") + 
  geom_point(aes(x = date, y = grv), col = "coral3", pch = 15) +
  facet_wrap(~depth, ncol = 3) 
  
