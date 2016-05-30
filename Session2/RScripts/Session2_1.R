setwd("D:/RCourse")


# Libraries ---------------------------------------------------------------
require(magrittr)

# read data ---------------------------------------------------------------
bio_data <- read.csv("Biomass_compiled.csv")

# dplyr -------------------------------------------------------------------
head(bio_data)
str(bio_data)

require(dplyr)

filter(bio_data, Variety == "Cardinal", Water == "WS")
filter(bio_data, Gain_TDM > 30, Gain_TDM < 32)

select(bio_data, Water:Tuber_FM)
select(bio_data, contains("Gain"))
select(bio_data, starts_with("Tuber"))
rename(bio_data, Tot_T = Total_T)

arrange(bio_data, Variety)
arrange(bio_data, desc(Replication))

mutate(bio_data, Replication = as.factor(Replication))
mutate(bio_data, Tuber_WM = Tuber_FM - Tuber_DM,
                 Tuber_WC = Tuber_WM/Tuber_FM)

bio_data_by_Var <- group_by(bio_data, Variety)
bio_data_by_Var_W <- group_by(bio_data, Variety, Water)

summarise(bio_data, mean_T = mean(Total_T))
summarise(bio_data_by_Var, mean_T = mean(Total_T))
summarise(bio_data_by_Var_W, mean_T = mean(Total_T),
                             mean_Gain_TDM = mean(Gain_TDM),
                             sd_Gain_TDM = sd(Gain_TDM))

sample_n(bio_data, 10)
sample_frac(bio_data, 0.05)


# reshape2 ----------------------------------------------------------------
require(reshape2)

bio_long <- melt(bio_data, id.vars = c("Water", "Variety", "Replication"), 
                 variable.name = "Parameter", value.name = "Mass")
bio_wide <- dcast(bio_long, Water + Variety + Replication ~ Parameter, value.var = "Mass")

# tidyr -------------------------------------------------------------------
require(tidyr)
bio_data %<>% mutate(label = "dummy.text")
separate(bio_data, label, into = c("L1", "L2"), sep = "\\.")
