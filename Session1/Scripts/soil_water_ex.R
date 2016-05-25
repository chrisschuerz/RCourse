# Working directory -------------------------------------------------------
setwd("C:/Users/Christoph/Desktop/R Course")
# Example soil water data -------------------------------------------------
soilwater_data <- read.table("wheat-soil_water.csv", skip = 4, nrows = 44,
                             sep = ",", fill = TRUE, stringsAsFactors = FALSE)
soilwater_data <- t(soilwater_data)
soilwater_data <- soilwater_data [,-c(3:4)]

header <- soilwater_data[2,]
header[1:2] <- c("depth", "date")
header[3:length(header)] <- paste("plot", header[3:length(header)], sep = "_")

soilwater_data <- soilwater_data[-c(1:5),]
soilwater_data <- soilwater_data[-c(1:5),]
colnames(soilwater_data) <- header

soilwater_data <- soilwater_data[1:437,]
soilwater_data <- as.data.frame(soilwater_data, stringsAsFactors = FALSE)

soilwater_data[,2] <- as.Date(soilwater_data[,2], "%d.%m.%y")
soilwater_data[,1] <- as.factor(as.numeric(soilwater_data[,1]))
for (i in 3:42) {
  soilwater_data[,i] <- as.numeric(soilwater_data[,i])
}

soilwater_data %>% 
  select(date, depth, 3:6) %>% 
  melt(id = c("date", "depth")) %>% 
  ggplot(.) +
  geom_line(aes(x = date, y = value, col = depth)) + 
  facet_wrap(~variable, ncol = 2)

# waterstress experiment --------------------------------------------------
require(ggplot2)

ws_data <- read.csv("Biomass_compiled.csv")
str(ws_data)
ggplot(ws_data) + 
  geom_violin(aes(x = Water, y = Total_T), fill = "grey80") +
  geom_boxplot(aes(x = Water, y = Total_T), width = 0.1) +
  facet_grid(~Variety)


ws_aov <- aov(Total_T ~ Water*Variety, data = ws_data)
ws_lm  <- lm(Total_T ~ Water*Variety, data = ws_data)

summary(ws_aov)
summary(ws_lm)
anova(ws_lm)
ws_HSD <- TukeyHSD(ws_aov)
ws_HSD_WV <- as.data.frame(ws_HSD$`Water:Variety`)
ws_HSD_WV$comparison <- rownames(ws_HSD$`Water:Variety`)
lbl_list <- unlist(strsplit(ws_HSD_WV$comparison, "\\:|\\-"))
ws_HSD_WV <- ws_HSD_WV[lbl_list[seq(2, length(lbl_list), 4)] == 
                         lbl_list[seq(4, length(lbl_list), 4)],]


ws_data$residuals <- ws_aov$residuals
ws_data$fitted_value <- ws_aov$fitted.values

ggplot(ws_data) + 
  geom_point(aes(x = fitted_value, y = residuals, col = Variety))

ggplot(ws_data) + 
  stat_qq(aes(sample = residuals))

ggplot(ws_HSD_WV) + 
  geom_pointrange(aes(x = comparison, y = diff, ymin = lwr, ymax = upr)) + 
  coord_flip()
