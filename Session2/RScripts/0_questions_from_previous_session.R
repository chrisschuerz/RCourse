# In this initial script I want to reply to questions from the previous session
# and also document some questions that came up during the current session.

# Working directory -------------------------------------------------------
setwd("C:/Users/Christoph/Desktop/R Course")

# There were several questions according to specific analysis that migth be
# frequently required in agriculture, such as correlation analysis or ranking of
# means from an ANOVA. A very useful package for such analysis is the agricolae
# package.

# Packages ----------------------------------------------------------------
require(agricolae)

# load data ---------------------------------------------------------------
bio_data <- read.csv("Biomass_compiled.csv")

# Here I would like to demonstrate differences between functions from the base
# package (implemented in R) and the specific agricolae package. Both analyses
# do always basically the same. The function from agricolae often provides
# further information that might be valuable in an analysis.

# Analysis ----------------------------------------------------------------
# Here a correlation analysis for 7 variables of tio bio data set was done. Once
# with the base function, the second time with the function from agricolae. Just
# look at the results to see the difference. The function correlation()
# additionally provides p Values
cor_base <- cor(bio_data[,4:10])
cor_agri <- correlation(bio_data[,4:10])

bio_aov <- aov(Gain_TDM ~ Water + Variety + Water*Variety, data = bio_data)

# Here the HSD analysis is done using the function HSD.test from agricolae.
# Compared to the base function TukeyHSD(), that we used last week this function
# also gives a ranking and groups as an output.
bio_HSD <- HSD.test(bio_aov, c("Water", "Variety"))
bio_HSD$groups
bio_HSD <- HSD.test(bio_aov, c("Water"))
bio_HSD$groups


# write subset to csv file ------------------------------------------------
bio_sub <- filter(bio_data, Water == "WW")
write.csv(bio_sub,"bio_sub.csv")
# Some questions came up about writing data. This example uses the more general
# form for writing data, the write.table() function. It allows more options
# compared to e.g. write.csv(). Here we set some options such as:
# - The output is a .txt file as we gave the file ending .txt
# - we set the tabulator as seperator sign by "\t"
# - we ommited quotation of text strings in the output and
# - we disabled to print row names in the output
write.table(bio_sub, "bio_sub.txt", sep = "\t", quote = FALSE,
            row.names = FALSE)

# There are many more options for writing data. But for further details check
# out the help file for write.table()
