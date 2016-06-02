# Plotting overview of bio data -------------------------------------------
bio_data %<>% mutate(Replication = as.factor(Replication))

ggplot(bio_data) + 
  geom_violin(aes(x = Water, y = Gain_TDM), fill = "grey80") + 
  geom_boxplot(aes(x = Water, y = Gain_TDM), width = 0.1) + 
  facet_wrap(~Variety)col = as.factor(depth)

ggplot(bio_data) + 
  geom_violin(aes(x = Variety, y = Gain_TDM, fill = Water),position=position_dodge(0.5)) + 
  geom_boxplot(aes(x = Variety, y = Gain_TDM, position = Water), position=position_dodge(0.5), width = 0.1)

# Example with classical boxplot() function
par(mfrow = c(3,3))
boxplot(Gain_TDM~Water, data = bio_data[bio_data$Variety == "Caesar",],
        ylab = "Gain_TDM", main = "Caesar", ylim = c(10,35))
boxplot(Gain_TDM~Water, data = bio_data[bio_data$Variety == "Cardinal",],
        ylab = "Gain_TDM", main = "Cardinal", ylim = c(10,35))
boxplot(Gain_TDM~Water, data = bio_data[bio_data$Variety == "Desiree",],
        ylab = "Gain_TDM", main = "Desiree", ylim = c(10,35))
boxplot(Gain_TDM~Water, data = bio_data[bio_data$Variety == "Diamant",],
        ylab = "Gain_TDM", main = "Diamant", ylim = c(10,35))
boxplot(Gain_TDM~Water, data = bio_data[bio_data$Variety == "Farida",],
        ylab = "Gain_TDM", main = "Farida", ylim = c(10,35))
boxplot(Gain_TDM~Water, data = bio_data[bio_data$Variety == "Mondial",],
        ylab = "Gain_TDM", main = "Mondial", ylim = c(10,35))
boxplot(Gain_TDM~Water, data = bio_data[bio_data$Variety == "Spunta",],
        ylab = "Gain_TDM", main = "Spunta", ylim = c(10,35))

# Plotting results of water content data ----------------------------------
ggplot(data = SD2C) +
  geom_line(aes(x = date, y = sim)) + 
  geom_pointrange(aes(x = date, y = obs_mean, ymin = obs_lw, ymax = obs_up), 
                  col = "cadetblue") + 
  geom_point(aes(x = date, y = grv), col = "coral3", pch = 15) +
  facet_wrap(~depth, ncol = 4) 






