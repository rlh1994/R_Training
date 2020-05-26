#  /------------------------------------------------------------------------------------------\
#  |   ____                   _       _____                                 _           _     |
#  |  |  _ \    __ _   _ __  | |_    |___ /   _      __ _    __ _   _ __   | |   ___   | |_   |
#  |  | |_) |  / _` | | '__| | __|     |_ \  (_)    / _` |  / _` | | '_ \  | |  / _ \  | __|  |
#  |  |  __/  | (_| | | |    | |_     ___) |  _    | (_| | | (_| | | |_) | | | | (_) | | |_   | 
#  |  |_|      \__,_| |_|     \__|   |____/  (_)    \__, |  \__, | | .__/  |_|  \___/   \__|  |
#  |                                                |___/   |___/  |_|                        |  
#  \------------------------------------------------------------------------------------------/

# Libraries ---------------------------------------------------------------
library("dplyr")
library("ggplot2")



# What is the grammer of graphics? ----------------------------------------

# In extremely simple terms, the grammer of graphics is the idea that a graphic is like a language,
# it can be made up different pieces, the way a sentence is made of nouns, verbs, adjectives etc.

# By the end of this file you'll be able to plot 5 different variables on the same graphic, now let's get started...


# Elements of a basic graph -----------------------------------------------

# Let's start by adding our data to the plot
ggplot(data = diamonds)

# But there's nothing there? Just a completey blank plot. That's because we have a dictionary,
# words we can use, but haven't put them in a sentence yet!

# Next we can tell the plot what aestetics to use. This is like picking the nouns of our sentance
ggplot(data = diamonds, aes(x = carat, y = price))

# We now have some axes, and the ranges are right, but we don't have our data plotted yet.
# We haven't told it how to put it all together yet.

# Now we need to add a geom, these are the elements that get actually added to plot (kind of like verbs)
# Importantly you need to ADD this to the plot, not pipe it like before
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point()

# There we go! Our data (53,940 data points!) is plotted in 2 lines.

# It's a bit hard to see because there's so many points, let's make them a bit more transparent using the alpha option
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(alpha = 1 / 100)

# Our Aestetic was set globally, for every geom, but we can overwrite them per geom as well
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(aes(col = clarity)) # different colours representing the diffeent clarity of each point/diamond

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(aes(col = cut)) # different colours representing the different cut for each point/diamond

# This opens up a lot of possibilities, we can even change the axis for each geom!
# Of course we now need to change the axis label as well
ggplot(data = diamonds, aes(y = price)) +
  geom_point(aes(x = x, col = "red")) +
  geom_point(aes(x = z, col = "blue")) +
  xlab("Dimension")

# But wait the colours aren't what we said???
# That's because the aestetic just grouped them by the string value, as if that was a column for the datapoint.
# This is a very important fact, anything in the aestetic is part of the underlying data, anything outside the aestetic is part of the geom.
ggplot(data = diamonds, aes(y = price)) +
  geom_point(aes(x = x), col = 'red') +
  geom_point(aes(x = z), col = "blue") +
  xlab("Dimension")

# The problem with that one is there was no legend to tell us which one was which...
# To get around this we can either accept the default colour choices
ggplot(data = diamonds, aes(y = price)) +
  geom_point(aes(x = x, col = 'x')) +
  geom_point(aes(x = z, col = "z")) +
  xlab("Dimension")

# Or we can use scale_colour_manual to overwrite the colours.
# This function takes the values as a named vector (using the =) or in alphabetical order for the colours you want to use,
# the labels you want to give to those values, and the title you want to give the legend.
ggplot(data = diamonds, aes(y = price)) +
  geom_point(aes(x = x, col = "xs")) +
  geom_point(aes(x = z, col = "zs")) +
  xlab("Dimension") +
  scale_color_manual(values = c("xs" = "red", "zs" = "blue"), labels = c("X", "Z"), name = "Custom legend\ntitle")

# Manually specifying things in ggplot is possible, but usually a bit more complex than letting it do it for you
# In particular, anything to do with legends tends to be really fiddely. Often you can just stick with the defaults and not have a problem.


# Exercises ---------------------------------------------------------------


# 1) Create a scatter plot that visualises how the width ('x') and depth ('z') of diamond varies



# 2) Are there any outlier values? Remove these from the data then re-plot



# 3) Now have the colour of the points vary by clarity



# 4) Now have the size of the points vary by carat



# 5) Label your axis using xlab() and ylab(), and add a title using ggtitle()


# 6) Run the following lines of code to get a new dataset, there is something hidden in this data, can you find it?
source("Image_Challenge/produceImageData.R")
challenge_data <- make_challenge_data()


# Linear Models -----------------------------------------------------------

# We aren't covering modelling in this training, although R is obviously optimised and desgined for it
# But how complex is it to add a linear model to a plot?

# Let's start using our pipes again as well
diamonds %>%
  filter(cut == "Good", color == "J", clarity == "SI1") %>% # compare like for like
  ggplot(aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm", col = "purple")

# That's it! We've got a linear model (and a loess model) plotted on our data. Be careful, this doesn't tell us anything about
# if the model is any good, or what it might suggest, but it's extremely easy to add.


# Facets ------------------------------------------------------------------

# Now for something even more incredible, we can easily split our plots out by a variable using 1 line
diamonds %>%
  ggplot(aes(x = carat, y = price)) +
  geom_point(aes(col = clarity)) +
  facet_wrap(~cut) # Notice that ~ for an equation again. This time the equation is the "x" value of the plots

# Or, we can even split it out by two variables!
diamonds %>%
  ggplot(aes(x = carat, y = price)) +
  geom_point(aes(col = clarity)) +
  facet_grid(color ~ cut)

# because of the ranges, it might be more useful to not have the same ranges on all the axes
diamonds %>%
  ggplot(aes(x = carat, y = price)) +
  geom_point(aes(col = clarity)) +
  facet_grid(color ~ cut, scales = "free")



# The big Finale ----------------------------------------------------------
library(ggthemes)
diamonds %>%
  ggplot(aes(x = carat, y = price)) +
  geom_point(aes(col = clarity)) +
  facet_grid(color ~ cut, scales = "free") +
  geom_smooth(method = "lm", col = "red") +
  labs(x = "Carat (weight of diamond)", y = "Price ($)", title = "Comparison of diamond properties") +
  theme_wsj()

# Note, just because you *can* plot 5+ different dimensions of your data in a single plot, doesn't mean you should (and often you shouldn't!).
# There's a big difference between a full visualisation and an effective visualisation. https://graphicsprinciples.github.io/ is a good resource.



# Exercises ---------------------------------------------------------------


# 1) Make a plot using mtcars of hp vs mpg, colour it by cylinder
# can you make the cyl discrete? try as.character()



# 2) Now split it out into facets by cylinder instead



# 3) Load the iris datasdet and examine it. Plot Sepal length vs petal length



# 4) Now colour it by the species



# 5) Now split them out using facets and create a line of best fit for each (think about your scales)
# Which species seem to follow a linear trend?



# 6) Use the nycflights13::flights dataset and see if you can work out how to create a boxplot
# of arrival delay, by month, setting the y axis limits to between -20 and 20
# Hint: boxplot only NEEDS a y value




# Useful Links -------------------------------------------------------------

# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html
# GGplot 2 workshop part 1, by the maintainer of the package https://youtu.be/h29g21z0a68

