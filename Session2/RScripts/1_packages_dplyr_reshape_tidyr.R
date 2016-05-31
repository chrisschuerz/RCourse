# Set wd ------------------------------------------------------------------ 
# As in the previous examples it is advisable to keep data, scripts and results
# in one folder. In order to tell R where to look for files and where to save
# results you can set the working directory.
setwd("C:/Users/Christoph/Desktop/R Course")


b

# Load data ---------------------------------------------------------------
# In this example we again use the biomass data set we know already from the
# previous session. As done before we load the data with read.csv() and save 
# it tothe variable bio_data
bio_data <- read.csv("Biomass_compiled.csv")


# dplyr -------------------------------------------------------------------
# In this section I demonstrate useful functions from the dplyr package. The
# package is very useful for filtering data, selecting specific columns of a
# data set, rearranging, summarizing or calculating with your data.

# As we have done before it is always advisable first to look over your data
# before working with it. The function head() simply shows the first few rows of
# your data (tail() would show the last rows.). The function str() as we know
# already gives you an overview of the data structure.
head(bio_data)
str(bio_data)

# -------------------------------------------------------------------------
# The first function I want to demonstrate is filter(). It works rowwise and
# filters all rows where the logical queries I apply are TRUE.

# In the following example I extract the rows where Variety is "Caesar" and
# where the the Variable Water is "WW" (well watered). So I extract the data for
# well watered Caesar varieties.
filter(bio_data, Variety == "Caesar", Water == "WW")

# Here I filter the rows where the Gain_TDM is greater or equal to 30 but lower
# than 31.
filter(bio_data, Gain_TDM >= 30, Gain_TDM < 31)

# -------------------------------------------------------------------------
# Here I give examples for the function select() which works columnwise. By
# giving the column headers I can select or remove specific columns from the
# data set

# Here I select the columns Water, Variety, and Shoot_DM
select(bio_data, Water, Variety, Shoot_DM)

# To remove columns simply assign them with -. To give a range from one column
# to another you can indicate this with the double colon. In this example we
# remove the columns Water until Total_T from the data set
select(bio_data, -(Water:Total_T))

# Here we select all columns where the header contains the characters "_DM". So
# all columns for dry mass data.
select(bio_data, contains("_DM"))

# To get all columns where the header starts with "Leaf" we can do as follows 
select(bio_data, starts_with("Leaf"))

# As in "classical" subsetting we can also give the indices of the columns
select(bio_data, 7:10)
bio_data[,7:10]

# To rename a column simply use the function rename as follows
rename(bio_data, Leaf_dm = Leaf_DM)


# -------------------------------------------------------------------------
# With the function arrange() you can order your data ascending or descending in
# the order of the variables you give to the function.

# In this example we first sort the data in descending order for Shoot_DM and
# then in alphabetical order for Variety
arrange(bio_data, desc(Shoot_DM), Variety)



# ------------------------------------------------------------------------- 
# To calculate new variables (so new columns) from the other variables you can
# apply the function mutate() (there is also the function transmutate() where
# you only keep the calculated variable and remoce all the others.). When
# calculating several new variables in one command you can use right away the
# variables yo just calculated.

# In this example I first transformed the variable Replication to a factor (as
# we also did in the previous session, but now with the command mutate.).
# Additionally I calculated the tuber water mass and aplying the new variable
# directly I also calculated the tuber water content.
bio_data <- mutate(bio_data, Replication = as.factor(Replication),
                             Tuber_WM = Tuber_FM - Tuber_DM,
                             Tuber_WC = Tuber_WM/Tuber_FM)


# Two functions that are very useful in combination are group_by() and
# summarise(). When applying group_by() there is no big change for the user to
# see. In the background however (in the attributes of the data set) the data
# set is now grouped by the variables chosen.

# Here I grouped our data set by only the varieties, and in a second case by
# varieties and Water. I stored these new grouped data sets to new variables.
bio_data_by_Var <- group_by(bio_data, Variety)
bio_data_by_Var_Water <- group_by(bio_data, Variety, Water)

# The difference between these data sets becomes obvious when the function
# summarise() is applied to the data. With the function summarise() many
# differnt functions (e.g. mean, sd, but also any individual function) can be
# applied to the data and stored to new variables. To see the differences in the
# groupings try following examples.
summarise(bio_data_by_Var, mean_T = mean(Total_T))
summarise(bio_data, mean_T = mean(Total_T))
summarise(bio_data_by_Var_Water, mean_T    = mean(Total_T), 
                                 sd_T      = sd(Total_T),
                                 mean_Gain = mean(Gain_TDM),
                                 n_samp    = length(Total_T),
                                 se_T      = sd_T/sqrt(n_samp))

# Somtimes it can be useful to draw random samples from your data this can be
# done either by the number of samples (in the function sample_n()) or by a
# fraction of your data set (with sample_frac())
sample_n(bio_data, 10)
sample_frac(bio_data, .25)


# reshape2 ----------------------------------------------------------------
# The package reshape2 offers the functionality to transform your data from a
# long into a wide format and the other way round. To understand the difference
# between these formats follow the next two examples.

# Here I selected only the first three colmns and the variable Gain_TDM. I
# rearranged the data set to give the values of Gain_TDM in columns for each
# Variety. With the  function melt() I brought the data set back into its
# initial long form.
GAIN <- select(bio_data, Water:Replication, Gain_TDM)
GAIN_wide <- dcast(GAIN, Water + Replication ~ Variety, value.var = "Gain_TDM")
GAIN_long <- melt(GAIN_wide, id.vars = c("Water", "Replication"), variable.name = "Variety",value.name = "Gain_TDM")

# Similar as above I brought now the whole data set into the long format and
# transformed it back afterwards to wide format.
bio_long <- melt(bio_data, id.vars = c("Water", "Variety", "Replication"))
bio_wide <- dcast(bio_long, Water + Variety + Replication ~ variable, value.var = "value")


# tidyr ------------------------------------------------------------------- 
# Finally a very useful function from the tidyr package is the function
# separate() where you can separate the values in one column by a separator
# symbol

# In this example I added the column label holding the values "dummy.text". With
# the funciton separate I separated the column into two columns L1 and L2 und
# separated the values "dummy.text" into "dummy" and "text" by the point as
# seperator.
bio_data <- mutate(bio_data, label = "dummy.text")
separate(bio_data, label, into = c("L1", "L2"), sep = "\\.")

