# Working directory -------------------------------------------------------
setwd("C:/Users/Christoph/Desktop/R Course")
# Packages ----------------------------------------------------------------
require(agricolae)
library(agricolae)

# load data ---------------------------------------------------------------
bio_data <- read.csv("Biomass_compiled.csv")


# Analysis ----------------------------------------------------------------
cor(bio_data[,4:10])
cor_bio <- correlation(bio_data[,4:10])

bio_aov <- aov(Gain_TDM ~ Water + Variety + Water*Variety, data = bio_data)
bio_HSD <- HSD.test(bio_aov, c("Water", "Variety"))
bio_HSD$groups
bio_HSD <- HSD.test(bio_aov, c("Water"))
bio_HSD$groups


# write subset to csv file ------------------------------------------------
bio_sub <- filter(bio_data, Water == "WW")
write.csv(bio_sub,"bio_sub.csv")
write.table(bio_sub, "bio_sub", sep = "\t", quote = FALSE,
            row.names = FALSE)
