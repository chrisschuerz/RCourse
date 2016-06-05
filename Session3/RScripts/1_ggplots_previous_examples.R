#In the following examples I explain the plots I presented already in the
#previous sessions. For the boxplots from session 1 I also tried a similar plot
#with the base barplot() function.

# Plotting overview of bio data -------------------------------------------
# Again we define Replication as factor variable
bio_data <- mutate(bio_data, Replication = as.factor(Replication))

# Every ggplot starts with the command ggplot() further layers and controls for 
# labels, legends etc. are added with a "+". In this example I defined the data
# I want to work with already in the ggplot() command and the aesthetics (x, y,
# etc.) for the individual layers. I could have also defined the data in the
# individual layers, but also define the aesthetics in the ggplot() command, as
# illustrated in further examples.
ggplot(data = bio_data) + 
  # For plotting a violinplot I added the layer violin(), on the x axis I plot
  # the variable water and on the y axis the Gain. I fill the boxes with gray
  # color.
  geom_violin(aes(x = Water, y = Gain_TDM),fill = "grey80") + 
  # Over the violin plot I plot a boxplot with the same aesthetics (Therfore I
  # could have added them already in the ggplot() command and ommit them in the
  # layers.). As I want the boxes to be very thin I set the width to 0.1
  geom_boxplot(aes(x = Water, y = Gain_TDM), width = 0.1) + 
  # I want to seperate the plots for the individual varieties. This is done with
  # a facet command (in this case facet_wrap) and the information for which
  # variable to separate. I also added the number of columns I want to arrange
  # the plots.
  facet_wrap(~Variety, ncol = 2)


# The very same information content can be illustrated in a different way. Here
# I added all varieties into one plot window and seperated for each variety the
# plots by their fill colors.

# Again start with a ggplot() command.
ggplot(bio_data) + 
  # I again start with a violin layer but in this case x is Variety and the fill
  # color is controlled by the variable Water. Please see that fill is now 
  # defined inside the aes() command and not outside as in the previous example.
  # To control the distance between the violins of WS and WW I use the position
  # command.
  geom_violin(aes(x = Variety, y = Gain_TDM, fill = Water),
              position=position_dodge(0.5)) + 
  # The same I repeat for the boxplot layer.
  geom_boxplot(aes(x = Variety, y = Gain_TDM, position = Water), 
               position=position_dodge(0.5), width = 0.1)



# Example with classical boxplot() function. This example illustrates that a
# similar plot as in the first example done with the basic plot commands can be
# rather tidious. This does not mean that basic plot functions are in general
# worse than ggplot(), they have some advantages in other situations. But I
# prefer ggplot in most situations.
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

# Again start with a ggplot() command. As date is plotted on the x axis for all
# three layers I added it directly to the ggplot command.
ggplot(data = SD2C, aes(x = date)) +
  # The first layer I add is a line plot for the simulated time series. So the
  # aesthetic y is sim.
  geom_line(aes(y = sim)) +
  # As next layer I add the water content measurements for which the statistics
  # mean, and standard error were calculated. To visualize mean and errors in
  # the plot I used the geometry pointrange, where I set y, ymin and ymax
  geom_pointrange(aes(y = obs_mean, ymin = obs_lw, ymax = obs_up), col = "cadetblue") +
  # For the gravimetric measurements single values per timestep and depth are
  # available. I added them as points to the plots.
  geom_point(aes(y = grv), col = "coral3", pch = 15) +
  # Again I wanted to seperate the plots for the individual depths for the
  # measurements. As done before I apply a facet command for the variable depth
  facet_wrap(~depth, ncol = 4) 






