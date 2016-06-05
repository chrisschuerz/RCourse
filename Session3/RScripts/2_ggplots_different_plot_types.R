# Different plot types ----------------------------------------------------

# In the following examples I want to demonstrate different ggplot geometries to
# present different types of variables (eg. one continuous variable, one 
# descrete and one continuous, etc.). When easily possible I also tried to get a
# similar example with the basic plot commands.


# One continuous variable ------------------------------------------------- 
# Histograms Histograms are a good way to illustrate the distribution for single
# continuous variables. As in the previous examples the ggplot starts with a
# ggplot() command.
ggplot() + 
  # The geometry to use is geom_histogram(). As only one variable is
  # illustrated, the aesthetics only require a x Variable. I distributed the
  # data over 10 bins (10 classes).
  geom_histogram(data = bio_data, aes(x = Gain_TDM), bins = 10) + 
  # When now separating the plots for the variable Water you can see that the
  # number of bins is defined for the data first and applied to the two plots
  # the same way. This gives you a good comparability of the two subsets of the
  # data.
  facet_wrap(~Water)


# The basic plot command for a histogram is hist(). To do the separation for the
# variable Water I need to separate the plot window first with the par() command
# and set the option of mfrow to 1 row and 2 columns.
par(mfrow = c(1,2))
# After that I plot the histograms for the two subsets Water == "WS" and Water == "WW".
hist(bio_data$Gain_TDM[bio_data$Water == "WS"], 
     main = "WS", xlab = "Gain_TDM", breaks = 10)
hist(bio_data$Gain_TDM[bio_data$Water == "WW"], 
     main = "WW", xlab = "Gain_TDM", breaks = 10)
# Here you see that the bins are individual for both plots and the data is
# difficult to compare. In order to achieve the same result you would have to
# set the breaks for the classes individually.

# To close the plot window with the separation into two subplots I close the plotting device with the command dev.off()
dev.off()

# Two continuous variables ------------------------------------------------ 
# Point plots In this example I use two continuous variables from the bio data
# set. What I want to point out in this example are the possibilities to control
# the information content of a plot by using different aesthetics such as x,y,
# col, size, shape, or aplha (hue of the data point). (Nevertheless the plot
# here makes sense or not).
ggplot(data = bio_data, aes(x = Total_T, y = Gain_TDM)) + 
  geom_point(aes(col = Variety, size = Water, 
                 alpha = Total_T, shape = Replication)) + 
  # I also fitted a linear model to the data set with the command geom_smooth.
  geom_smooth(method = "lm") +
  # Again I sepearated into individual plots for the different varieties.
  facet_wrap(~Variety, ncol = 2)

# The basic plot command for point data in R is plot()
plot(bio_data$Total_T, bio_data$Gain_TDM, xlab = "Total_T", ylab = "Gain_TDM")



# x is descrete, y is continuous ------------------------------------------

# In your discipline data is often given as continuous properties (e.g. weight,
# length) for different categories (e.g. crop varieties, treatments). A very
# common way to illustrate such information is a barplot.

# Barplots with error bars

# As demonstrated in session 2 we have to derive some statistical measures of
# our data to visualize them in a further step with ggplot.
# Here we saw in the previous session, that the functions group_by() and
# summarise(), both from the dplyr package, are very useful.
bio_summary <- bio_data %>% 
  # Group bio data by the variables Variety and Water
  group_by(Variety, Water) %>% 
  # Summarise and calculate metrics: mean of Total_T for each group
  summarise(T_mean = mean(Total_T), 
            # Standard deviation for each group
            T_sd   = sd(Total_T),
            #Tthe number of samples each group contains. (length() of a vector
            #usually gives the number og elements a vector contains)
            n_samp = length(Total_T),
            # Standard error for each group
            T_se   = T_sd/sqrt(n_samp),
            # Lower and upper boundary for the error bars
            T_lwbd = T_mean - T_se,
            T_upbd = T_mean + T_se)

# To visualize the barplot with error bars we again start with the ggplot()
# command. Here I added the data and the aesthetics that should be controlled by
# variables (x,y, and the fill of the bars) directly in the ggplot() command.
ggplot(data = bio_summary, aes(x = Variety, y = T_mean, fill = Water)) + 
  # As a first layer I add the geomotry bar. As you also can read in the ggplot
  # cheatsheet, when using the geom_bar() as we do we have to set the option
  # stat to "Identity". We want to plot the bars for "WW" and "WS" beside each
  # other. So we set again the position to "dodge".
  geom_bar(stat = "Identity", position = position_dodge(1)) + 
  # As a further layer we add errorbars. As additional aesthetics we need the
  # min and max values. Again we use the position_dodge, to plot the error bars
  # for "WS" and "WW" beside each other. To make the errorbar caps smaller width
  # was set to 0.5
  geom_errorbar(aes(ymin = T_lwbd, ymax = T_upbd), 
                position = position_dodge(1), width = 0.5) + 
  # To color the bars manually we can add the layer scale_fill and give the
  # manual colors as values to the layer.
  scale_fill_manual(values = c("cadetblue3","coral3" )) + 
  # There are many more possibilities to refine your plot such as flipping the
  # plot. For specific functionalities I recommend to google and go for good
  # posts in online communities such as stackoverflow, or for the chaptersabout
  # plotting in the R cookbook.
  coord_flip()