install.packages("ggplot2")
install.packages("dplyr")

#anything that starts with a hash does not run (its a comment), 
#its the same as  -- in SQL 

#This is the notebook window, it's where you can write scripts to be run again (and easy to edit)
#Below if the console window, this is where the commands are actually run and the output is given
#If the console shows a > on the bottom line it is ready to accept new commands,
#If it shows a + it is expecting more input (usually you forgot to close a bracket)
#If it shows nothing, R is running something and you should wait before giving it another command
#To the upper right is the enviornment space where you can see all the stored data
#Bottom right is files, plots, packages and help (help is very useful!)

x <- 10 # assigning the value 10 to the word x #
x = 10 # you should use <- rather than =
#this has just stored the value in x (see top right) to display the value we need to return the variable
x

#we can do basic arithmatic and either print of store the result
x <- 10*3 #notice this overwrites out previous x
x/10
x**2 ##power

# a vector of numbers (using c to combine the values)
x <- c(10,11,12,13,14,15) # has now been reassigned to this, a vector of numbers (a chain of numbers together is a vector)
x*2 # every element in the vector (line) is multiplied by 2 individually and not combined together

# accessing different elements of the vector using []
x[1] # the first value in the vector 
x[-3] # removing the 3rd value from the vector (12)
1:4
x[1:4] # first 4 values of the vector
x > 12
x[x > 12] # elements of x that are greater than the number 12, and thus it pulls those larger values out of the vector
x[x == 14] # == is asking when this statement is true, and thus is saying that x is equal to 14

x == 14 # cheching when x is equal to 14 along the vector, and thus comes up with a result of FALSE FALSE FALSE FALSE TRUE FALSE 

# a vector of characters wors in the same way, not just going to be using numbers e.g. BVHG
y <- c("a","b","c","r","k")
y
y[1] # again first element of vector
y[y =='c']

# Automic Vectors
# all elements of ana automatic vector must be the same type
# Logical, integer, double (numeric), character
# A mixture of numbers and characters
z <- c("a","b",1, 3, pi, "character string", "123") # because the numbers are in "" treating it as a character(as a string), this means that they are numric representations of the characters

# all elements have been COERCED to the most flexible type, in this case letters(characters) 
z[3] + z[4] # this will not run because they are a non numeric argument to a binary operator (using a non numerical character to answer a numerical question)
x[3] + x[4]

# example of basic functions
# computing the arithmetic mean 
mean # pressing F1 whilst pressing the function key and whith the cursor on the function (in this case "mean") will load the help 
mean(x) # finding the mean of all the valies in the vextor of x
mean(x=c(1,2,3,4,5,6), trim = 0, na.rm=FALSE) # here wanting to work out the mean of x and we are telling is that x is (1,2,3,4,5,6)
# trim removes outliers, the fraction (0 to 0.5) of observations to be trimmed from each end of x before the mean is computed. Values of trim outside that range are taken as the nearest endpoint.


#have a play around with some base r features, make some vectors and see how you can access elements, see what functions there are etc



#create (google how to create) a mode function, what does each part do?
getmode <- function(v) {
    univ <- unique(v)
    univ[which.max(tabulate(match(v, univ)))]
}
x <- c(3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1, 1,5,6,3,5,7,100,100,100,100,100,100,100,100)
getmode(x)
univ <- unique(x)
match(x, univ)
tabulate(match(x, univ))
which.max(tabulate(match(x, univ)))
univ[which.max(tabulate(match(x, univ)))]

#Some additional stuff 
str <- "this is a test string"
substr(str, 15, 20) #the usual functions you want exist (but note the different variables compared to sql, start and stop not start and length)
length(x) #length of a vector (numbre of elements)
length(str) #Returns 1 why? Because in R everything is a vector, this string is a vector of 1 element
nchar(str) #use nchar to get the "length" of the string
seq(from = 1, to = 100, by = 10) #produces a generic sequence 


#################

library(dplyr)
library(ggplot2)

diamonds

# under each column it tells you what type of data is in each, double (has decimal places), integers (no deicimal places), 
# ordered (a column of factors, the different values that a data type can have that correspond to each of those factors e.g. E,I,J)
# each row refers to one measurement of one diamond 
# a tibble is a wrapper for a data set

summary(diamonds) # shows basic stats and brakdown of the dataset, which in this case is diamonds
glimpse(diamonds)
str(diamonds)


# filter by the property of a column
filter(diamonds, price > 15000) # this filters the dataset and orders by those that are 15,000 or more (in terms of price)
filter(diamonds, color == 'D') # only showing diamonds with the colour 'D', NOTE: case sensitive
filter(diamonds, color == 'D', clarity == 'IF') # SO IF WANT TO ORDER BY 2 VARIABLES (SO THOSE THAT ARE THE COLOUR 'D' AND THE CLARITY IS 'IF') JUST SEPERATE THE 2 BY A COMMA IN THE CODE
filter(diamonds, color == 'D' | price < 10000) # you can use | to represent the logical or (! can be used for not)
filter(diamonds, depth > 60, (color == 'D' | price < 10000))
filter(diamonds, depth > 60, color == 'D' | price < 10000) #in this case the order and bracketing doesn't matter, but for 
#readability and certainty you should always try to bracket closed logical statements (just like you would to help BODMAS in maths)


# save data from these tables my applyig it as a value to a set of or individual numbers 
# e.g.
abc <- filter(diamonds, color == 'D', clarity == 'IF')
# if you click on the variable in the top right box (abc) it will open the tabe up in another tab

# select columns you want to use
select(diamonds, cut) # this just cuts all of the data from a speacific columns and drops it in the console
select(diamonds, -cut)

# you can also specify a single (named) column by using the $ symbol
diamonds$clarity # this returns that column as a vector, can be useful in certain situations
pull(diamonds, clarity)

abc <- diamonds # the diamonds data is all now under the 'abc' variable, and thus using the 'abc' in functions accesses this dataset

arrange(abc, price) # default is ascending order of data provided
arrange(abc, desc(table)) # so if want to show data in descending format have to tell it to, so could descend it or ascend it through any of the numeric columns 
arrange(abc, color, table, desc(price)) # ranking the ordering, so if rank first by colour, and then rank all those 'D' diamonds by 'Table' 

# adding an extra column or mutating data in a clolumn
mutate(diamonds, price_GBP = price/1.3) # so the price data is in $ and we are converting it to £ and then inputting this info in another column. the 'price/1.3' represents the exchange rate from $ to £
mutate(abc, kg = carat / 5000)
mutate(abc, price = price * 1000) # all prices multiplied by 1000. Not adding a new column here, just mutating the info in a current column

mutate(abc, price = price * 1000,
       price_GBP = price/1.3,
       kg = carat / 5000,
       grams = kg * 1000)
# make sure you run all of the lines, by either highlighting them all and then running or presing run consecutively until it goes through all of the lines. 
# REMEMBER: 'abc' in this instance represents the whole 'diamonds' dataset

#------------------------------------------------------------------------------------------------
# Piping in dplyr (singular)
# ------------------------------------------------------------------------------------------------
    
# this is really really important
# it allows you to do multiple things at once 
# Old Way
arrange(select(filter(diamonds, price > 15000), price), desc(price))

#Piping method
diamonds %>% filter(price > 15000) %>% select(price) %>% arrange(desc(price))
# so here we are seeing all of those diamonds that are priced above 15,000, 
#taking this data and then only displaying the price column, 
#and finally taking this data and switching it from ascending to descending order to order the price from highest to lowest.


# PIPING EXERCISE 1
# create a dataftame that shows the price, carat and cut of all diamonds between $10,000 and $15,000 showing the biggest diamonds first
diamonds %>% mutate(size = x*y*z) %>% 
    select(price, carat, cut, size) %>% 
    filter (price>10000, price<15000) %>% 
    arrange(desc(size))

#-------------------------------------------------------------------------------------------------
    # Grouping
#-------------------------------------------------------------------------------------------------
    
# counting within a group 
    diamonds %>% 
    group_by(color) %>%
    summarise(total = n()) #summarise will give us the number of things in each of these groups, 
#showing how many measurements in each group, and it will also creat the new column, but not in the same way that mutate works 
# the 'group_by' function is grouping all colour groups together, summarise is then creating another column, then the (total = n()) shows you the total number of colours. 

diamonds %>% 
    group_by(color) %>%
    summarise(avg_price = mean(price)) %>%
    arrange(desc(avg_price)) # arranging by 'avg_price' because that is now the name of the column 

diamonds %>% 
    group_by(color) %>%
    summarise(ave_price = mean(price), total = n()) # creating 2 column's here with the ','(comma) separating the 2

diamonds %>%
    group_by(cut) %>%
    summarise(total = n()) # doing the same, but just with cut

diamonds %>%
    group_by(color, cut) %>%
    summarise(avg_price = mean(price), total = n()) %>%
    print(n=35) # this allows you to display all of the rows, and not the default display number. 

# Arrange by biggest group

diamonds %>%
       group_by(color, cut) %>%
       summarise(total = n()) %>%
       arrange(desc(total))

# Exercise 2
# create a dataframe that shows the min, max, mean and median prices of all diamonds grouped by colour and cut.
# arrange by the group with the least diamonds. 
diamonds %>%
    group_by(color, cut) %>%
    summarise(total = n(), 
              minimum = min(price), 
              maximum = max(price), 
              average = mean(price), 
              middle = median(price)) %>%
    ungroup() %>% # takes any background grouping and gets rid of it 
    arrange(total) %>%
    print(n=1)


# mtcars dply exercises
#
# Firstly, print out mtcars and have a look at it, use ?mtcars to read the help page about it
# Notice that the row numbers have been replaced by a name, that's because these rows have been specifically labelled
#
# Exercise 1
# 
# Print out the hp column using the select() function. Try using the pull() function instead of select to see what the difference is.
# 
# 
mtcars %>% select(hp) 
pull(mtcars, hp) 
# 
# Exercise 2
# 
# Print out the all but hp column using the select() function.
# 
# 
mtcars %>% select(-hp)
# 
# Exercise 3
# 
# Print out the mpg, hp, vs, am, gear columns. Consider using the colon : symbol to simplfy selection of consecutive columns.
# 
# 
mtcars %>% select(mpg, hp, vs:gear)
# 
# Exercise 4
# 
# Create the object mycars containing the columns mpg, hp columns but let the column names be miles_per_gallon, and horse_power respectively.
# 
# 
mtcars %>% select(miles_per_gallon = mpg, horse_power = hp) -> mycars
# 
# Exercise 5
# 
# Create a new variable in the mycars data frame km_per_litre using the mutate() function. Hint: 1 mpg is 0.425 km/l.
# 
# 
mycars <- mycars %>% 
    mutate(
        km_per_litre = 0.425*miles_per_gallon
    )
# 
# Exercise 6
# 
# Randomly select and print half the observations of mycars. Hint: consider using the sample_frac() function
# 
# 
mycars %>% sample_frac(size = 0.5, replace = FALSE)
# 
# Exercise 7
# 
# Create a mycars_s object, containing from 10th to 35th row of mycars. Hint: Consider using the slice() function.
# 
mycars_s <- mycars %>% slice(10:35)
# 
# Exercise 8
# 
# Print out the mycars_s object without any duplicates. Hint: Consider using the distinct() function.
# 
mycars_s %>% distinct()
# 
# Exercise 9
# 
# Print out from mycars_s object all the observations which have mpg>20 and hp>100.
# 
mycars_s %>% filter(miles_per_gallon > 20, 
                    horse_power > 100)
# 
# Exercise 10
# 
# Print out the row corresponding to the Lotus Europa car hint: use the row.names()
# 
mtcars %>% mutate(car_name = row.names(mtcars)) %>%
                      filter(row.names(mtcars) == "Lotus Europa")
#
# Exercise 11
# 
# Create a table that gives the total number of cars and the average mpg by number of cylinders
#
#
mtcars %>% group_by(cyl) %>% summarise(total = n(), avg_mpg = mean(mpg))
#
# Exercise 12
# 
# By number of gears, what is the max horsepower and average weight
#
#
mtcars %>% group_by(gear) %>% summarise(max_hp = max(hp), avg_weight = mean(wt))
#
# Bonus Exercise
# 
# By brand of car (first word before the space in the row names) and cyclinder, what is the average and max mpg and hp 
#
# hint: you will need to google how to get the part of the string you want.
# if you cannot find it, use this link (but ask us, it's important to know how to google questions corretly!) https://stackoverflow.com/questions/15895050/


mtcars %>% mutate(brand = gsub( " .*$", "", row.names(mtcars))) %>%
    group_by(brand, cyl) %>%
    summarise(avg_mpg = mean(mpg), max_mpg = max(mpg),
              avg_hp = mean(hp), max_hp = max(hp))




#--------------------------------------
 #   --------------------------------------
    # ggplot2 - the grammer of graphics
 #   --------------------------------------
#    --------------------------------------
    
    ggplot(data = diamonds)
# this doesnt plot anything! we have not told ggplot2 what to plot
# we do this by setting an aesthetic, 'aes()'

ggplot(data = diamonds, aes(x = carat, y = price))
# still no data, it just creates the axes. we need to tell it how we want to map the data into the plot
# lets use points 'geom_point', to creates the plot.

ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point()

ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(alpha = 1/100) # alpha changes the density of the dots so its easier to see the density of points when you have a large amount of data
# NOTE: over 1000 is too transparent

ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point()+
    geom_smooth()+ # creating the line of best fit, but you can make the line follow a more linear path as seen below by adding additional parameters.
    geom_smooth(method = "lm", color="purple") # creating a straight trend line, or in other words a linear method (hence the 'lm').

# mapping further aesthetics
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(col=clarity)) # different colours representing the diffeent clarity of each point/diamond

ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(col=cut)) # different colours representing the different cut for each point/diamond 

# Exercise 1
# create a scatter plot that visualises how the width ('x') and depth ('z') of diamond varies 
# make the colour vary by clarity, and the size vary by carat (how do you think you would do this?)

ggplot(data = diamonds, aes(x = x, y = z)) +
    geom_point(aes(size=carat, col=clarity))
# do you see any outliers that we need to be able to get rid of these before ggplot?

diamonds %>%
    filter(z > 0,z < 30) %>%
    ggplot(aes(x = x, y = z)) +
    geom_point(aes(size=carat, col=clarity)) # NOTE: need to remove "diamonds" from ggplot function becasue would conflict with filtered data

diamonds %>%
    filter(z > 0,z < 30) %>%
    ggplot(aes(x = x, y = z)) +
    geom_point(aes(size=carat, col=clarity))+ # using a discreet variable, so only a finite range and thus the colours are seperate
    geom_smooth(method = "lm", color = "purple")

diamonds %>%
    filter(z > 0,z < 30) %>%
    ggplot(aes(x = x, y = z)) +
    geom_point(aes(size=carat, col=carat))+ # using a continuous variable, and thus the key is a contunous variation
    geom_smooth(method = "lm", color = "purple")

# Facetting 

# by one variable 
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(col=clarity))+
    facet_wrap(~cut) # seperating by 3 variables, creates a seperate graph for each of the variables in the brackets (in terms of cut)

ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(col=clarity))+
    facet_grid(color~cut, scales = "free") #free scales custs the dead space in the graphs

#by two variables 
diamonds %>% filter(price >10000, price<15000) %>%
    ggplot(aes(x = carat, y = price)) +
    geom_point(aes(col=clarity))+
    facet_grid(color~cut, scales = "free")

# Exercise 1
#Make a plot using mtcars of hp vs mpg, colour it by cylinder
mtcars %>% ggplot(aes(x = hp, y = mpg, col = as.character(cyl))) + geom_point()
#can you make the cyl discrete? try as.character()

#Exercise 2
# Create a histogram using the diamonds dataset for the width of the diamonds
diamonds %>% filter(x > 0) %>% ggplot(aes(x = x)) + geom_histogram()
# Create a 2d histogram comparing colour (spelt color...) and carat, it's called a stat_bin_2d!
diamonds %>% filter(x > 0, z>0, z< 30) %>% ggplot(aes(x = color, y = carat)) + stat_bin_2d()
#------------------------------
    # Boxplots and Violins
    #------------------------------
    
    ggplot(diamonds, aes(clarity, price))+ 
    geom_boxplot(aes(fill = clarity))
# this shows the distribution of values (showing the range, IQ range, about 95% of the data is withing the whiskas(the lines), and the rest is in the outlier dots)
# can only use with a discrete variable

diamonds %>%
    filter(carat == 1) %>%
    ggplot(aes(clarity, price))+ 
    geom_boxplot(aes(fill = clarity))
# now we have scaled to weight, only the same size or diamonds are shown 

#violin - shows you a little bit more about the distribution of the values than boxplots 

diamonds %>%
  filter(carat == 1) %>%
  ggplot(aes(clarity, price))+ 
  geom_boxplot(aes(fill = clarity))+
  geom_violin(aes(fill = clarity, alpha = 1/2))

# alpha (or transparency) is an aesthetic feature, and thus you should insert them in the aesthetic box of the plot you want to manipluate. You can seperate these aeshtetic qualities with a 'comma' (,)
# you can layer a violin ontop of a boxplot


## Now you have the basics of dplyr and ggplot2, pretty much everything else is learning to combine these things, 
# thinking of smart ways to do things, pretty ways to display things, and googling how to do things!
# Some useful things you might end up using are melt(), gather(), read.csv(), paste(), left_join() and many many more!

#Use any remaining time to play about with what you've learnt, there's quite a few datasets you can use. Ask questions while you can!
# diamonds
# mtcars
# iris
#nycflights13 (a few of these) - good to practise joins - flights is the best for full data
