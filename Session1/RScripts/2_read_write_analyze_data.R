# Packages ----------------------------------------------------------------
# Loading the ggplot2 package for plotting the data (more to that in Session 3)
require(ggplot2)

# Working directory -------------------------------------------------------
# Setting the working directory to the folder where the data is located
setwd("C:/Users/Christoph/Desktop/R Course")

# Read in Data ------------------------------------------------------------
# Read in the csv file with the standard read.csv command
bio_data <- read.csv("Biomass_compiled.csv")

# First analysis of data --------------------------------------------------
# Analize the structure of the data (data types of columns, range of values)
str(bio_data)

# The column Replication should be of type factor, as the numeric values
# (1,2,3,4,5) have no numeric meaning (We could have also said R1, R2,...).
# Therfore we convert the data type to factor.
bio_data$Replication <- as.factor(bio_data$Replication)

# Summary of the data. Gives min, max, quantile, and mean values for numeric
# variables and number of counts for factors, dates...
summary(bio_data)

# First plot of the data --------------------------------------------------
# Visualization of the data. Just to show you. More about that in Session 3
ggplot(bio_data) + 
  geom_violin(aes(x = Water, y = Total_T), fill = "grey80") + 
  geom_boxplot(aes(x = Water, y = Total_T), width = 0.1) + 
  facet_wrap(~Variety)

# ANOVA -------------------------------------------------------------------
# Applying two way ANNOVA to the data
bio_aov <- aov(Gain_TDM ~ Water + Variety + Water*Variety, data = bio_data)

# Getting the results of the ANNOVA with summary
summary(bio_aov)

# Applying the Tukey honest significant differences test to our ANNOVA model
bio_THSD <- TukeyHSD(bio_aov, ordered = TRUE)

# Write Data -------------------------------------------------------------- 
# Writing the results of our TukeyHSD test to a csv file in our working
# directory
write.csv(x = bio_THSD$`Water:Variety`, file = "tukey_HSD.csv")
