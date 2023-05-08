## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Title: Homework#2
## Author: Qinan You
## Date: 2/25/2021


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
########### RUBRIC
# Follow the formatting, fill in the heading above, and keep the structure of the file name.
# Adding extra comments are welcome if they can help me to understand what you're doing (and can earn extra points).


########### HELPFUL HINTS
# Put comments (i.e. text for humans to read, not the computer) to the right of a #, like so.
# To run your code, highlight the entire line and press the 'cntrl' and 'enter' keys at the same time.
  # R will ignore commented remarked (after a #) as long as you capture the # in the highlight.
# R is case sensitive!
# Pay close attention to commas and parentheses - they can trip you up!
# If you're stuck, use the ? command, or search in the "help" window in the lower right hand screen.
# Run *and understand* the example code before you try the homework.


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
########### Environmental (workspace) setup
#NOTE: This section, including remove() and library(), should be copy-pasted to the top any RScripts you create for homeworks.
  #It helps you make sure your workspace is clear and set up, ready to go.  This is to make sure you homework goes smoothly. 

#### Clear all objects (which include datasets, variables, etc) using the remove() function
remove( list = objects() )    # Start with a clean slate, telling R to remove() the full list of all objects

#### Libraries
## Activate the installed package 
  #NOTE: you need to do use library() every time you use R
library(ggplot2)
library(openintro)

#### Downloading datasets
#Download datasets from online repositories
source("http://www.openintro.org/stat/data/cdc.R")      # downloads the dataset called "cdc"
smoking <- smoking                                      # downloads the dataset called "smoking"

## Just run this code as well, to make sure things aren't displaying with scientific notation
options(scipen = 100, digits = 4)


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
########### Basic R


## Assign the value '100' to a new variable 'x'
x <-100

## Assign the list '95, 67, 80' to a new variable 'scores', 
scores <- c(95,67,80)

## Write the code to ask R for help with the function ggplot()  (you must have the library ggplot2 activated to look up ggplot)
?ggplot



## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
########### Working with datasets in R  
#--- DEMO CODE, this is to help you prepare for the homework section at end.  

  ##STOP!  BEFORE you try any of the code below, make sure you have: 
      #1) run the code for the libraries ggplot and openintro
      #2) downloaded the dataset(s) at the top of the RScript.


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
########### Practicing the basics  

##NOTE: If you get stuck, review the R resources posted in Courses under Week1.  If you are STILL stuck, let me know. 
##NOTE: Below, you will replicate the code above, but for the "cdc" dataset, instead of the "present" dataset
    ##STOP!  BEFORE you try any of the code below, make sure you have: 
      #1) run the code for the libary ggplot and 
      #2) downloaded the two datasets at the top of the RScript.

## Create the following variable, then:
measurements <- c(60, 67.5, 55, 61.5, 76, 70.5, 78, 59, 68, 68, 67.5, 64, 62)

  ## write the code that computes the mean of measurements
  mean(measurements)
  
  ## write the code that computes the median of measurements
  median(measurements)
  
  ## write the code that computes the median of measurements
  median(measurements)
  
  ## use the function summary() and calculate the IQR of measurements
  summary(measurements)
  #IQR=Q3-Q1=68-61.5=6.5



## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
########### Practicing with the cdc dataset

## Write the code to look at the first few lines of the cdc dataset
head(cdc)


## Write the code to look at the last few lines of the cdc dataset
tail(cdc)


## How many observations are there in this data set?  
dim(cdc) #There are 20000 observations in the data set.


## How many variables? What are their names? For each variable, identify its data type (e.g. categorical, discrete).
names(cdc)
  #genhlth -  categorical, ordinal
  #exerany - categorical, binary
  #hlthplan - categorical, binary
  #smoke100 - categorical, binary
  #height - numerical, continuous
  #weight - numerical, continuous
  #wtdesire - numerical, continuous
  #age - numerical, continuous
  #gender - categorical, nominal 


##Write the code to examine the variable column "height" in the cdc dataset
cdc$height


## Run and take a look at the following data visualizations. 
  ## You will answer questions on them in the Courses homework sheet
 
  ## Gender
  ggplot(data = cdc, aes(x = gender)) +
    geom_bar()

  
  ## Height x Weight
  ggplot(data = cdc, aes(x = height, y = weight)) +
    geom_point()

  ##  Age x weight
  ggplot(data = cdc, aes(x = age, y = weight)) +
    geom_point()
  
  ## Age x height
  ggplot(data = cdc, aes(x = age, y = height)) +
    geom_point()




## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
########### Practicing with the smoking dataset

## First, look at the documentation for this dataset
?smoking


## How many observations are there in this data set?  
dim(smoking)
#There are 1691 observations in the data set. 


## How many variables? What are their names? For each variable, identify its data type (e.g. categorical, discrete).
names(smoking)
#gender - categorical nominal
#age - numerical continuous
#marital-status - categorical nominal
#highest-qualification - categorical nominal
#nationality - categorical nominal
#ethnicity - categorical nominal 
#gross-income - categorical ordinal
#region - categorical nominal
#smoke - categorical binary 
#amt_weekends - numerical discrete
#amt_weekdays - numerical discrete
#type - categorical nominal

## What does the empty category represent in the bar chart of "type"?  
  #Hint: try looking at the actual dataset and/or the dataset documentation
ggplot(data = smoking, aes(x = type)) + 
  geom_bar()


## Histograms for smoking on weekends vs. weekdays
ggplot(data = smoking, aes(x = amt_weekends)) + 
  geom_histogram(binwidth = 5) + 
  ggtitle("Number of cigarettes smoked per weekend day")

  ggplot(data = smoking, aes(x = amt_weekdays)) + 
    geom_histogram(binwidth = 5) + 
    ggtitle("Number of cigarettes smoked per weekday")

  
## What is the median of the amount smoked on the weekend?
median(smoking$amt_weekends, na.rm = TRUE)  
  #notice we had to add an argument na.rm=TRUE, to remove the NA (missing) values for non-smokers
  
  ## What is the mean of the amount smoked on the weekend?
  mean(smoking$amt_weekends, na.rm = TRUE)
  
  ## What is the sd of the amount smoked on the weekend?
  sd(smoking$amt_weekends, na.rm = TRUE)
  

## What is the median of the amount smoked on the weekday?  (repeat the code in the section above on the new variable)
median(smoking$amt_weekdays, na.rm = TRUE)

  ## What is the mean of the amount smoked on the weekday?
mean(smoking$amt_weekdays, na.rm = TRUE)

  ## What is the sd of the amount smoked on the weekday?
sd(smoking$amt_weekdays, na.rm = TRUE)
  
 ##What is the IQR of the amount smoked on the weekdays?
  IQR(smoking$amt_weekdays, na.rm = TRUE)
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#### You did it!  Great job taking your first big step to learning a new computer language!
## Please provide a time estimate on how long the R code portion of the homework took you. 
##1 hour with the Course assignment 

## REMEMBER, PLEASE FILL OUT YOUR NAME and the date in the template above (lines 1 -3) 
  # and also in the title of the file.
  





