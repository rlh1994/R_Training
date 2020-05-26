#  /-------------------------------------------------------------------------------------\
#  |   ____                   _       _  _           ____        ____       __   __      |  
#  |  |  _ \    __ _   _ __  | |_    | || |    _    |  _ \      |  _ \      \ \ / /      | 
#  |  | |_) |  / _` | | '__| | __|   | || |_  (_)   | | | |     | |_) |      \ V /       | 
#  |  |  __/  | (_| | | |    | |_    |__   _|  _    | |_| |  _  |  _ <   _    | |    _   | 
#  |  |_|      \__,_| |_|     \__|      |_|   (_)   |____/  (_) |_| \_\ (_)   |_|   (_)  |
#  |                                                                                     |
#  \-------------------------------------------------------------------------------------/

# DRY ---------------------------------------------------------------------

# DRY stands for Don't Repeat Yourself and is a core programming methodology and ethos.
# The idea is simple, repeating yourself is bad for a number of reasons:
#   1) People are lazy, why would you write the same things many times when you could just write it once?
#   2) If you have to change something in your code, wouldn't it be better to change it once and not 10 times?
#       This would lead to less chance of an error or missing something, and again see point 1 about being lazy.
#   3) Chances are if you needed something 3 times you're likely to need it more than 3, why not stop repeating yourself early?
#   4) Seeing the same 10 lines of code over and over makes reading it hard.

# The following session covers ways to avoid repeating yourself in R, either by having to have different files to run
#   slightly different code, by doing the same thing many times in a row, or by wanting to do the same thing with slightly different inputs.

# There are some cases against DRY (mostly in the case of functions). It can make your code harder to understand as 
#   details are abstracted away in code defined elsewhere. It can also make debugging your code harder for the same reason.
#   But overall, this will save you more problems than it creates.


# Conditional Execution ---------------------------------------------------

# Something every programming lanaguage has to give you the ability to do is conditionally execute code.
# We've already seen this in the lesson where we used if_else or case_when, but these are dplyr functions 
#   that act on records in a dataframe. What if you wanted to only run an entire block of code if a condition is TRUE?
# That's where if statements come in, they add conditional branches to your code based on some logical test.

# The structure if as follows:
# if (condition1) {
#   # run when condition1 is TRUE
# } else if (condition2) { # can have as many else ifs as you want
#   # run when condition1 is FALSE, but condition2 is TRUE
# } else {
#   # run when none of the other tests are true
# }

# This isn't a very useful example, but it shows you the core structure of an if/else block and what it does.
x <- 1:30
if (length(x) > 20) {
  print("That's a long vector!")
} else if (length(x) > 10) {
  print("That's a decent sized vector.")
} else {
  print("Did you even try...")
}

x <- 1:15
if (length(x) > 20) {
  print("That's a long vector!")
} else if (length(x) > 10) {
  print("That's a decent sized vector.")
} else {
  print("Did you even try...")
}

x <- 1:5
if (length(x) > 20) {
  print("That's a long vector!")
} else if (length(x) > 10) {
  print("That's a decent sized vector.")
} else {
  print("Did you even try...")
}


# Loops -------------------------------------------------------------------

# Sometimes you want to do the same thing many times, maybe across multiple bits of data?
# To do this we can use loops, either for loops or while loops.
# Usually because R is vectorised, you shouldn't need to use a loop to take an action on a variable, 
#   only if you need to do something multiple times.

# A for loop runs through each item in it's vector once, doing whatever is in the loop each time
for (n in x) {
  print(paste("The loop is currently on", n))
}

# A while loop keeps going until it's condition is false (it finishes the current loop)
# Make sure your loop will reach that false condition or it will run forever!
y <- 0
while (y < 7) {
  print(paste("The current value of y is", y))
  y <- y + 1
}


# Custom functions --------------------------------------------------------

# Often you may find yourself doing the same thing over and over in the code; you can't do it in a for loop
#   because each one is slighlty different but similar enough that only a few bits of the process change.
#   This is when you can define your own function to do the work for you!

# Just like inbuilt functions, they are defined by 3 things
# Its arguments, also called inputs
# What it does
# Its return value/Output if it has one

# A function gets assigned to a variable just like anything else, we define what inputs it has, we write the code inside
#   the function for what it does, and then we tell it what to return to the user

# This function takes two numbers, x and y and calcualted 2*x + y, stores this in z then returns that value to the user.
myfunc <- function(x, y) {
  z <- 2 * x + y
  return(z)
}

myfunc(5, 7)

# Notice that z doesn't ever appear in our environment? This is because z only exists within the scope of the function call. This
#   means that we can never access it outside of that function. R also makes sure that any arguments you pass are copied within that function
#   so there's no way you can change the value of your inputs (without being very hacky about it).
func2 <- function(x){
  x <- x + 5
}

x <- 5
x
func2(x)
x

# Quiz --------------------------------------------------------------------



# Exercises ---------------------------------------------------------------

# 1) Use a while loop to print out all the square numbers less than 1061000
# Bonus to tell me what number squared is the closest but still beneath it



# 2) Create a variable called `year` and assign this year to it. Now use a conditional statement to test if 
#   it is a leap year (evenly divisible by 4, not evenly divisible by 100 unless it is evenly divisible by 400).
#   Check this works for other years to ensure it works.



# 3) Combine a loop and a conditional statement to cycle through all elements in the vector 1:30 
#   and print out each value with whether it is even or odd



# 4) Take your answer from exercise 2 and instead turn it into a function that takes a value for the year,
#   prints a string telling you if it is a leap year or not, and return TRUE or FALSE



# 5) Use a while loop to generate the Fibonacci numbers less than 1000



# 6) Create a function that takes a value, n, and returns that Fibonacci number
