#  /-----------------------------------------------------------------------------\
#  |   ____                   _       _         _           _                    |
#  |  |  _ \    __ _   _ __  | |_    / |  _    (_)  _ __   | |_   _ __    ___    |
#  |  | |_) |  / _` | | '__| | __|   | | (_)   | | | '_ \  | __| | '__|  / _ \   |
#  |  |  __/  | (_| | | |    | |_    | |  _    | | | | | | | |_  | |    | (_) |  |
#  |  |_|      \__,_| |_|     \__|   |_| (_)   |_| |_| |_|  \__| |_|     \___/   |
#  |                                                                             |
#  \-----------------------------------------------------------------------------/
                                                                                    

# install.packages("rmarkdown")
# install.packages("learnr")
# install.packages("shiny")



# RStudio -----------------------------------------------------------------

# Anything that starts with a hash does not run (its a comment),
# It's the same as  -- in SQL

# This is the notebook window, it's where you can write scripts to be run again (and easy to edit)
# Below is the console window, this is where the commands are actually run and the output is given
# If the console shows a > on the bottom line it is ready to accept new commands,
# If it shows a + it is expecting more input (usually you forgot to close a bracket)
# If it shows nothing, R is running something and you should wait before giving it another command
# To the upper right is the environment space where you can see all the stored data
# Bottom right is files, plots, packages and help (help is very useful!)



# Variable assignment & basic maths -----------------------------------------------------

# A variable is an object that we can store something in and refer to later.
# It could store a number, a table of data, a picture, or pretty much anything else!
# To start off we will just assign a number to the variable x (store 10 in x)

x <- 10   # Assigning the value 10 to the variable x
x = 10    # You can use = rather than <- but it is not recommended as it will cause problems later

# To see what x refers to we just run x and it will print out what it is. We can also look at it in the
# environment window
x

# Note that R is case sensitive
X <- 11

# You can also assign a variable using a right assignment operator, although the need to do so is rare
5 -> x

# We can do basic arithmetic and either print or store the result
x <- 10 * 3   # Notice this overwrites our previous x
x / 10        # Prints out the answer, but doesn't save it anywhere
x**2          # Exponents a.k.a power


# Vectors ----------------------------------------------------------------

# Next we can look at vectors. Vectors are an ordered collection of values of the same type
# We can assign a vector to any variable name, and the vector can be as long as we like (even empty)
# We create a vector by using the c() function which stands for combine.

x <- c(10, 11, 12, 13, 14, 15)    # x has now been reassigned to this, a vector of numbers
x * 2                             # Operations are applied element wise i.e. every element in the vector is multiplied by 2 individually

# That last line is more powerful than you realise. (Nearly) everything in R is a vector or is vectorised
# That means that functions can work very quickly on a lot of data. The [1] you have seen in the terminal
# when printing out single values is the index of the first value on that line. So even the number 1 is a vector!
1

# Now we know everything is a vector, how do we access different elements of them?
x[1]        # the first value in the vector
x[-3]       # removing the 3rd value from the vector (12)
1:4         # Shorthand for c(1, 2, 3, 4)
x[1:4]      # first 4 values of the vector

# We can use a comparison operator to check a condition on each vector element, and get a vector of booleans
x > 12      # Evaluates this condition across each element of the vector, giving a vector in return
x[x > 12]   # Use that boolean vector to select elements of the main vector
x[x == 14]  # == is asking when this statement is true, and thus is saying that x is equal to 14
x[7]        # if you ask for an element that doesn't exist, you get an NA

# Just to really hit home that a single number is treated as a vector of length 1 in 1
1[1]

# A vector of characters works in the same way
y <- c("a", "b", "c", "r", "k")
y
y[1] # Again first element of vector
y[y == "c"]

# Notice that in the environment window it tells you what type the variable is, so x is numeric and y is characters

# If we try to combine types, we'll see that R automatically converts them to the type that it can store
# them all as. It goes boolean -> number -> string
z <- c("a", "b", 1, 3, pi, "character string", "123")

# all elements have been COERCED to the most flexible type, in this case characters
z[3] + z[4] # this will not run because they are a non numeric argument to a binary operator (using a non numerical character to answer a numerical question)
x[3] + x[4]




# Functions ---------------------------------------------------------------

# A function can be defined by 3 things:
  # Its arguments, also called inputs
  # What it does
  # Its return value/Output if it has one

# In R, nearly all functions do not change the inputs in any way. This is known as functional programming, or side-effect free.

# Let's look at a basic function, the mean of a vector of values
mean     # pressing F1 with the cursor on the function (in this case "mean") will load the help
?mean    # you can also use `?` followed by the function name 
x <- 1:10
mean(x) # finding the mean of all the values in the vector of x

# We can see what some of these additional options do:
mean(x = c(1, 2, 3, 4, 5, 6, NA)) # We can't take the average with a missing value by default
mean(x = c(1, 2, 3, 4, 5, 6, NA), na.rm = TRUE) # This option removes the NAs during calculation
mean(x = c(1:10, 50))
mean(x = c(1:10, 50), trim = 0.1) # This removes 20% of the values (10% each end)

# Notice that in these we are setting the value of the argument named x, not the variable x in our environment
rm(x)
mean(x)
mean(x = 1:10)

# Some more functions
str <- "this is a test string"
vec <- 1:10
substr(str, 15, 20) # the usual functions you want exist (but note the different variables compared to sql, start and stop not start and length)
length(vec) # length of a vector (number of elements)
length(str) # Returns 1 why? Because in R everything is a vector, this string is a vector of 1 element
nchar(str) # use nchar to get the "length" of the string
seq(from = 1, to = 100, by = 10) # produces a generic sequence



# Quiz --------------------------------------------------------------------

rmarkdown::run("Quiz1/Quiz1.Rmd")


# Exercises ---------------------------------------------------------------
# 1) Assign your job title to a variable called job_title, and assign your boss' name to a vairable called boss



# 2) Create a vector of the numbers 1 to 10 and store it in a variable called nums



# 3) Take the vector nums and output the square of each number in it



# 4) Output just those elements of the vector nums that are less than or equal to 4



# 5) Produce another vector of the numbers -1 to -10 and store it in neg_nums. Output the sum
#     between elements of the two vectors i.e. the first element of nums + the first element of neg_nums etc



# 6) Generate a vector of numbers, starting at 13, ending at 190, in steps of 17.



# 7) Using Google (or another search engine), find a function to generate random values from a normal
#     distribution. Assign to a variable 100,000 randomly generated normally distributed values. What is their mean 
#     and what is their standard deviation (another function to look up)?