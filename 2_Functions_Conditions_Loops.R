.rs.restartR()
#### Functions ####

# A function can be defined by 3 things:
# Its arguments/Inputs
# What it does
# Its return value/Output

# Let's look at a basic function, the mean of a vector of values
mean # pressing F1 with the cursor on the function (in this case "mean") will load the help
x <- 1:10
mean(x) # finding the mean of all the values in the vector of x

# We can see what some of these additional options do:
mean(x = c(1, 2, 3, 4, 5, 6, NA)) # We can't take the average with a missing value by default
mean(x = c(1, 2, 3, 4, 5, 6, NA), na.rm = TRUE) # This option removes the NAs during calculation
mean(x = c(1, 2, 3, 4, 5, 6, NA), trim = 0.1, na.rm = TRUE) # This removes 20% of the values (10% each end)

# Some more functions 
str <- "this is a test string"
substr(str, 15, 20) # the usual functions you want exist (but note the different variables compared to sql, start and stop not start and length)
length(x) # length of a vector (number of elements)
length(str) # Returns 1 why? Because in R everything is a vector, this string is a vector of 1 element
nchar(str) # use nchar to get the "length" of the string
seq(from = 1, to = 100, by = 10) # produces a generic sequence

# Finally, not covered in detail is how to create your own functions. This can sometimes come in handy but
# is not more for reference at this point so don't worry too much about it.
myfunc <- function(x, y){
  z <- 2*x + y
  return(z)
}

myfunc(5, 7)

#### Conditionals ####

# We will see some more useful conditionals later in the lesson, but you will sometimes want to do one thing
# or another depending on certain conditions. Here's an example in case you ever need it
if (length(x) > 20){
  print("That's a long vector!")
} else if (length(x) > 10){
  print("That's a decent sized vector.")
} else {
  print("Did you even try...")
}

#### Loops ####

# Sometimes you want to do the same thing many times, maybe across multiple bits of data?
# To do this we can use loops, either for loops or while loops.
# Usually you shouldn't need to use a loop to take an action on a variable, only if you need to do something multiple times

# A for loop runs through each item in it's vector once, doing whatever is in the loop each time
for (n in x) {
  print(paste("The loop is currently on", n))
}

# A while loop keeps going until it's condition is false (it finishes it's current loop)
# Make sure your loop will reach that false condition or it will run forever!
y <- 0 
while (y < 7){
  print(paste('The current value of y is', y))
  y <- y + 1
}

#### Quiz #### 

rmarkdown::run("Quiz1/Quiz1.Rmd")

#### Exercises ####

# 1) Generate a vector of numbers, starting at 13, ending at 190, in steps of 17.



# 2) Combine a loop and a conditional statement to cycle through all elements in the vector you just created
# and print out each value with whether it is even or odd (you may need to google how to find that)



# 3) Use a while loop to print out the print out all the square numbers less than 1061000
# Bonus to tell me what number squared is the closest but still beneath it



# 4) R has a mean and a median function, create/find one using google but make sure to try and
# understand how it works!



# Bonus: Use a while loop to generate the Fibonacci numbers less than 1000
# Bonus: Create a function that takes a value, n, and returns that Fibonacci number


