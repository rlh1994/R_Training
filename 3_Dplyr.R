.rs.restartR()
#### Libraries ####
# install.packages(dplyr)
# install.packages(ggplot2)
library("dplyr")
library("ggplot2")

?dplyr
?ggplot2

#### Diamonds and data exploration ####
# Diamonds is a built in dataset that comes with ggplot2. We can find out more about it in the usual way
?diamonds
diamonds

# It is a variable pointing to a dataset, just like any other, we can always overwrite it
diamonds <- 4
diamonds

# Let's put it back to what it was before by specifying what library object we are referencing
diamonds <- ggplot2::diamonds
# Or by removing the global object entirely
rm(diamonds)

# Now we can look at the data in a few different ways rather than just printing it out like above
head(diamonds) # Print out the first 6 (by default) rows
str(diamonds) # View the structure of the dataframe
summary(diamonds) # Produces a statistical summary of all the columns in the dataframe
View(diamonds) # Open a viewer window of the dataframe

# But what is a dataframe? A data frame is used for storing data tables.
# It is a list of vectors of equal length.
# For most purposes, you can think of it like a table, or a spreadsheet. It has columns of records of equal type,
# and rows of equal length. Because it is a list of vectors, we can access it the same way we are used to

diamonds[1] # default if only one number is provided is to select that column
diamonds[2, 5] # Two values gives you the vector of rows, columns you want. Note that row number is relative here
diamonds[1:5, 5:6] # We can give full ranges as before
diamonds[, "carat"] # An empty vector means all, and you can specify columns by name
diamonds$price # This returns the particular column as a pure vector, not a dataframe
pull(diamonds, price) # Same as above, but useful in certain cases where you cannot $ the dataframe
diamonds[, "price"] # Notice the difference

diamonds[diamonds$price > 5000, ] # Finally, we can filter our rows in the same way, but in a slightly changed way


#### Piping ####
# Before we get into the main functions of dplyr we should discuss one of the most useful tools in all of R, the pipe.
# The pipe comes orginally from the magrittr package and implements a very simple idea.
# What is on the left of the pipe, is passed as the first argument to the right of the pipe.

# Consider the basic example

c(1, 2, 3, 4, 5, 6, 7, 10) %>%
  mean() %>%
  paste("is the mean of the vector")

# The premise of piping is simple, but its ability to make it easier to read, write, and edit code is incredible

# In the rare case you need to pass it as not the first argument, you use a . to indicate where the piped argument would go

c(1, 2, 3, 4, 5, 6, 7, 10) %>%
  mean() %>%
  paste("The mean of the vector is", .)


#### Selecting, Filtering, and Arranging ####

# Now we have our dataframe and know an easier way to use a chain of functions, let's look at some dplyr functions
# The first things we might want to so are only look at certain columns of our data (selecting)
# Look at only certain rows of our data (filtering)
# Order out data in a particular way (arranging)

# Let's start with some examples of select

# Select a single column
diamonds %>%
  select(carat)

# Select multiple columns
diamonds %>%
  select(
    carat,
    cut,
    color
  )

# Select all but a few columns
diamonds %>%
  select(
    -color,
    -cut,
    -x,
    -y
  )

# Finally we can do some more complicated stuff: it makes the code harder to read and more likely to be wrong
diamonds %>%
  select(
    color:price,
    -table
  )
# Order is important here
diamonds %>%
  select(
    -table,
    color:price
  )
# Notice that as color:price contains table, it adds it back in on the end and returns all columns
# It is generally a bad idea to use a range in a select unless you are certain the column order
# will not change and you aren't using anthing else in the select.

# You can also use selecting columns as an opportunity to rename them
diamonds %>%
  select(
    price_usd = price,
    table,
    cut
  )

# Or you can use the rename function
diamonds %>%
  rename(price_usd = price)


# Now let's look at some examples of filter

# Filter on a single condition
diamonds %>%
  filter(carat > 4)

# Filter on multiple conditions using an AND
diamonds %>%
  filter(
    carat > 4,
    color == "J"
  ) # Notice the double equals
diamonds %>%
  filter(carat > 4,
    color = "J"
  ) # You will get an error if you use a single equals

# Filter on multiple conditions using an OR
diamonds %>%
  filter(carat > 4 | color == "J")

# Filtering with a mix of and and or
diamonds %>%
  filter(
    (carat > 4 | color == "J"),
    clarity == "SI1"
  )


# Finally, we can look at how to order our data. As in SQL this is an expensive operation and should
# only be done at the end and only when really needed
diamonds %>%
  arrange(price)

# We can arrange the data descending based on a column like so
diamonds %>%
  arrange(desc(price))
# or, if you really wanted
diamonds %>%
  arrange(price %>% desc())

# For ties we can define what to order on next
diamonds %>%
  arrange(desc(price), table)


#### Quiz 2 ####

rmarkdown::run("Quiz2/Quiz2.Rmd")

#### Exercises 1 ####

# The following exercises use the builtin mtcars dataset. First get familiar with it using the methods
# described above. Notice that this dataset has rownames rather than just rownumbers.

# 1) Print out the hp column using the select() function.
# Try using the pull() function instead of select to see what the difference is.


# 2) Print out the all but hp column using the select() function.



# 3) Print out the mpg, hp, vs, am, gear columns.
# Consider using the colon : symbol to simplfy selection of consecutive columns.



# 4) Create the object mycars containing the columns mpg, hp columns
# but let the column names be miles_per_gallon, and horse_power respectively.



# 5) To practise piping, create a dataftame that shows the mpg, wt and gear of all cars
# with a qsec between the mean and the 3rd quartile of the data, putting the heaviest cars first



#### Mutating ####

# install.packages("quantmod")

# If you want to add new columns based on a calculation, or change a column, you can use the mutate function
diamonds %>%
  mutate(kg = carat / 5000)

# We can create multiple new columns at once
diamonds %>%
  mutate(
    kg = carat / 5000,
    max_volume = x * y * z
  )

# We can also use a column that we JUST created to create another column
diamonds %>%
  mutate(
    kg = carat / 5000,
    grams = kg * 1000,
    max_volume = (x * y * z) / 1000, # cm^3,
    min_density = grams / max_volume
  ) # We'll come back to this one later

# There's some functions to make mutate more powerful including if_else and case_when.
diamonds %>%
  mutate(big = if_else(carat > 0.3, "Big", "Not so big"))

# Not going into this too much but ~ is a formula, so there's a "relationship" between the test and the answer
diamonds %>%
  mutate(price_range = case_when(
    price < 320 ~ "<320",
    price < 325 ~ "320-325",
    price < 330 ~ "325-330",
    price < 335 ~ "330-335",
    price < 340 ~ "335-340",
    TRUE ~ ">340"
  ))

# We can even bring in other information that could be useful.
# Our data is in dollars, say we want to know how much our diamonds are worth in pounds TODAY
exch_rate <- quantmod::getSymbols("GBPUSD=X", from = Sys.Date(), auto.assign = FALSE)
diamonds %>%
  mutate(price_GBP = price / as.numeric(exch_rate$`GBPUSD=X.Close`))
# The as.numeric as because the library pulls the data in a specific format.

# Finally, we usualy want to keep the changed dataframe somewhere so we should assign it to a variable
diamonds2 <- diamonds %>%
  mutate(
    kg = carat / 5000,
    grams = kg * 1000,
    max_volume = (x * y * z) / 1000, # cm^3,
    min_density = grams / max_volume
  )


#### Aggregating ####

# The final common thing we want to do with out data is group it and aggregate it (or get aggregate info)
# We do this using 2 functions, group_by and summarise

# Group by just groups our data, but doesn't do anything with it
diamonds %>%
  group_by(cut)

# Now it is grouped, we can use this to get aggreageted information in our mutate
diamonds %>%
  group_by(cut) %>%
  mutate(avg_price = mean(price))

# This can be useful to look at comparing a single item to the group
diamonds %>% group_by(cut) %>% mutate(
  avg_price = mean(price),
  below_above = if_else(price > avg_price, "Above", "Below")
)

# If instead, as is more often the case, we want to summarise our data, we use the summarise function

# Get a count of diamonds by cut
diamonds %>%
  group_by(cut) %>%
  summarise(count_col = n())

# We can group by multiple things
diamonds %>%
  group_by(cut, color) %>%
  summarise(count_col = n())

# Order is again important, although here it doesn't matter
# We can generate multiple columns at the same time
diamonds %>%
  group_by(cut, color) %>%
  summarise(
    count_col = n(),
    avg_price = mean(price),
    max_carat = max(carat)
  )

# Keeping data grouped can slow down calculations, once you are done with needing the group, you should ungroup the data
diamonds_grouped <-
  diamonds %>%
  group_by(cut, color, clarity) %>%
  ungroup()

is.grouped_df(diamonds_grouped)

# Doesn't matter how many times you reasign the variable
diamonds_grouped <-
  diamonds %>%
  group_by(cut, color, clarity)

diamonds_grouped2 <- diamonds_grouped

is.grouped_df(diamonds_grouped2)


diamonds_grouped2 <-
  diamonds_grouped %>%
  ungroup()
is.grouped_df(diamonds_grouped2)


#### Exporting and Importing Data ####
# You'll want to bring your own data into R to work with in the future.
# There are ways to connect directly to databases, read from online sources, or connect APIs
# But we'll just show you how to read and write CSVs here
mtcars <- mtcars

# First make sure you set your working directory to somewhere you know
# setwd("~/")

# write.csv() writes a dataframe to a csv file
write.csv(mtcars, "cars_data.csv", row.names = FALSE)
# There are many options and write.csv is sometimes not the best choice, remember to look it up in the help!

# Next we want to import our data
read.csv("cars_data.csv")
# Remember that we need to assign it to a variale, and notice that the we lost the row names
cars_imported <- read.csv("cars_data.csv")

# You may also want to look at the readxl package to go straight from excel instead of CSV.


#### Putting it all together ####

# Let's really use the power of pipes to do many steps in one go
# Let's go back to our density calculation:
# We got a max volume and therefore a minimum desity. How good is this?
# The density of diamonds is 3.51g/cm^3
diamonds %>%
  mutate(
    kg = carat / 5000,
    grams = kg * 1000,
    max_volume = (x * y * z) / 1000, # cm^3,
    min_density = grams / max_volume
  ) %>%
  filter(min_density > 3.51)

# Looks like there's some diamonds data with x or y or z of 0, let's get rid of them
# It's easy to slide the filter in earlier because of the pipes.
diamonds %>%
  filter(x > 0, y > 0, z > 0) %>%
  mutate(
    kg = carat / 5000,
    grams = kg * 1000,
    max_volume = (x * y * z) / 1000, # cm^3,
    min_density = grams / max_volume
  ) %>%
  filter(min_density > 3.51)

# Those 3 diamonds seem to have a bigger density than should be possible for their size, we might want to
# remove them from our data when we do analysis

# Let's get some information together about these diamonds so we know about them for the future.
diamonds %>%
  filter(x > 0, y > 0, z > 0) %>%
  mutate(
    kg = carat / 5000,
    grams = kg * 1000,
    max_volume = (x * y * z) / 1000, # cm^3,
    min_density = grams / max_volume
  ) %>%
  filter(min_density > 3.51) %>%
  summarise(
    cnt = n(),
    tot_price = sum(price),
    avg_carat = mean(carat),
    biggest = max(max_volume)
  )


#### Quiz 3 ####

rmarkdown::run("Quiz3/Quiz3.Rmd")

#### Exercises 2 ####


# 1) Create a new variable in the mycars data frame km_per_litre using the mutate() function. 
# Hint: 1 mpg is 0.425 km/l.


# 2) Randomly select and print half the observations of mycars. 
# Hint: consider using the sample_frac() function



# 3) Create a mycars_s object, containing from 10th to 35th row of mycars. 
# Hint: Consider using the slice() function.



# 4) Print out the mycars_s object without any duplicates. 
# Hint: Consider using the distinct() function.




# 5) Print out from mycars_s object all the observations which have mpg>20 and hp>100.




# 6) Print out the row corresponding to the Lotus Europa car hint: use the row.names()




# 7) Create a table that gives the total number of cars and the average mpg by number of cylinders



# 8) By number of gears, what is the max horsepower and average weight



# Bonus) By brand of car (first word before the space in the row names) and cyclinder, what is the average and max mpg and hp?
# hint: you will need to google how to get the part of the string you want.
# if you cannot find it, use this link (but ask, it's important to know how to google questions corretly!) https://stackoverflow.com/questions/15895050/




