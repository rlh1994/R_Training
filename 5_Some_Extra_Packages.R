.rs.restartR()
#### Libraries ####
install.packages(c("lubridate", "DataExplorer", "dbplyr", "esquisse", "rpivotTable"))


library("dplyr")
library("ggplot2")

#### DataExplorer ####
library("DataExplorer")

# Data explorer is a package designed to make it easier to run common exploratory data analysis (EDA) tasks and graphs
# You can run them individually, or you can generate a load at once by having it run a report. This is usually a good 
# place to start once you have a rough feel for the basics of the data.

create_report(diamonds)


#### Lubridate ####
library("lubridate")

# Lubridate exists to make it easier to work with dates in R. It includes functions to transform dates, manipulate them,
# alter them, and interogate them. Some of the basic examples are shown here but there are many many more.

ymd(20190430) # converting an integer to a date
today() 
now()
round_date(now(), "hour") # rounding now to the nearest hour
floor_date(now(), unit = "7 minutes") # flooring now to the nearest 7 minutes
floor_date(now(), unit = "5 years") # flooring now to the nearest 5 years
now() %>% `day<-`(7) %>% print() # changing only the day of the month of a date object
days_in_month(now()) # how many days are in a month
leap_year(now()) # is it a leap year?



#### Dbplyr ####
library("dbplyr")


# dbplyr is a package designed to let you query a database connection using dplyr functions, rather than writing SQL.
# It is still beneficial to know sql as not all functions have been translation, from either side, and the SQL dbplyr writes
# is not always the most efficient and never the easiest to read.

# Creating a connection to a database can be fiddly and time consuming so the following example is provided to show you what is
# possible, without the difficulty of actually connecting to a database.

df_oracle <- tbl_lazy(mtcars, src = simulate_oracle()) # generate a dummy table in a dummy database

df_oracle %>% 
    filter(mpg > 20) %>% 
    select(-gear, -drat, -hp, -disp) %>%
    arrange(desc(qsec)) %>% 
    show_query() # generate the SQL that would be run in the database


#### Some flashy packages that are nice but not always useful ####


library("esquisse")

# esquisse is a Shiny app that allows drag and drop creation of many basic ggplot charts, including
# labelling axis and colour pallettes etc. It can be useful but you lose a lot of customisation and it has trouble
# with larger datasets

esquisser(mtcars)


library(rpivotTable)

# I've never really used it, but if you like pivot tables in excel for quick summary analysis of data,
# which they are great for, there is a package that imitates the same functionality in R. It doesn't
# have some of the features while it also has some extras, but could be useful to see some summary info about the data
rpivotTable(diamonds)
