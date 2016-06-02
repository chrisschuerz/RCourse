# Different plot types ----------------------------------------------------

# Histograms
ggplot() + 
  geom_histogram(data = bio_data, aes(Gain_TDM), bins = 10) + 
  facet_wrap(~Water)

par(mfrow = c(1,2))
hist(bio_data$Gain_TDM[bio_data$Water == "WS"], main = "WS", xlab = "Gain_TDM", breaks = 10)
hist(bio_data$Gain_TDM[bio_data$Water == "WW"], main = "WW", xlab = "Gain_TDM", breaks = 10)
dev.off()

# Point plots
ggplot(data = bio_data) + 
  geom_point(aes(x = Total_T, y = Gain_TDM, col = Variety, size = Water, alpha = Total_T, shape = Replication)) + 
  geom_smooth(aes(x = Total_T, y = Gain_TDM),method = "lm") +
  facet_wrap(~Variety, ncol = 2)

plot(bio_data$Total_T, bio_data$Gain_TDM, xlab = "Total_T", ylab = "Gain_TDM")

# Barplots with errorbars
bio_summary <- bio_data %>% 
  group_by(Variety, Water) %>% 
  summarise(T_mean    = mean(Total_T), 
            T_sd      = sd(Total_T),
            n_samp    = length(Total_T),
            T_se      = T_sd/sqrt(n_samp)) %>% 
  mutate(T_lwbd = T_mean - T_se,
         T_upbd = T_mean + T_se)

ggplot(data = bio_summary, aes(x = Variety, y = T_mean, fill = Water)) + 
  geom_bar(stat = "Identity", position = position_dodge(1)) + 
  geom_errorbar(aes(ymin = T_lwbd, ymax = T_upbd), 
                position = position_dodge(1), width = 0.5) + 
  scale_fill_manual(values = c("cadetblue3","coral3" )) + 
  coord_flip()