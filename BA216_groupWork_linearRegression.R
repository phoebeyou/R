## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Title: In-class demo for simple linear regression
## Author: Qinan You (Phoebe)
## Date: 05.10.21


## NOTES:
# This example was adapted from -- http://htmlpreview.github.io/?https://github.com/andrewpbray/oiLabs-base-R/blob/master/simple_regression/simple_regression.html 
##Option 1: Dataset from - https://www.openintro.org/data/index.php?data=cia_factbook
##Option 2: Dataset from - https://www.openintro.org/data/index.php?data=mammals

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
########### EXAMPLE 1  ----------------- 


########### Environmental (workspace) setup
remove( list = objects() )    #clears all objects (which include datasets, variables, etc)

## Open and/or download the libraries (you will need to download statsr only the first time you use it)
library(ggplot2)
library(openintro)
#install.packages("statsr")   #Uncomment this to install the first time, only run it once. 
library(statsr)
#install.packages("dplyr")
library(dplyr)

########### Load data into the R environment, from the openintro library (which is why the code looks so simple and weird)

## NOTE!!! You may chose either of these two options  

##Option 1: Dataset from - https://www.openintro.org/data/index.php?data=cia_factbook
countryDataset <- cia_factbook
countryDataset <- na.omit(countryDataset)
?cia_factbook

##Option 2: Dataset from - https://www.openintro.org/data/index.php?data=mammals
mammals <- mammals
mammals <- na.omit(mammals)
?mammals


########### Exploring the dataset and checking for linear relationships 
## First, examine your chosen dataset (either 1 or 2), 
  #following the flow we used last class (below)


## Checking the names of the variables 
names(cia_factbook)

#Which variables are numerical?  Which are categorical?
#categorical variables: "country","area","birth_rate","death_rate"
#numerical variables: "infant_mortality_rate","internet_users","life_exp_at_birth","maternal_mortality_rate","net_migration_rate","population","population_growth_rate" 

## Checking the dimensions of the dataset
dim(cia_factbook)

#How many observations are there? How many variables?  
#There are 11 variables and 259 observations. 

#### Next, I want you to explore the relationship between AT LEAST three numerical variables using a scatterplot
## Please make sure you fill in the !!! both in the code and in the comments

## Remember, you should be able to explain why you think the x variable can predict the y variable.
    #There should be a logic as to why you think they may be connected!
## You'll pick two of these to continue onwards with corr() and lm()

## 1 - Exploring the relationship between country and birth_rate using a scatterplot
ggplot(cia_factbook, aes(x =country, y =birth_rate, alpha = 0.3)) +
  theme_bw() +
  geom_jitter()

## 2 - Exploring the relationship between infant_mortality_rate and population_growth_rate using a scatterplot
ggplot(cia_factbook, aes(x =infant_mortality_rate, y =population_growth_rate, alpha = 0.3)) +
  theme_bw() +
  geom_jitter()


## 3 - Exploring the relationship between population and life_exp_at_birth using a scatterplot
ggplot(cia_factbook, aes(x =population, y =life_exp_at_birth, alpha = 0.3)) +
  theme_bw() +
  geom_jitter()




########### Correlation 
## Quantify the strength of at least two LINEAR relationships with the correlation coefficient.

## Correlation1 -- birth_rate and population
cor(cia_factbook$birth_rate, cia_factbook$population)
## Why do you think there will be a relationship between these two?
#It is possible that with the increase of birth rate, the population will increase as well.

## Correlation2 -- population and death_rate
cor(cia_factbook$population, cia_factbook$death_rate)
## Why do you think there will be a relationship between these two?
#It is possible that with the increase of death rate, the population will decrease.


########### The linear model
## Now, ask R to minimize the SSR using the lm() function 
## Do this for at least two linear regression models

##Model 1 -- regression model for independent variable birth_rate and dependent variable population
model1 <- lm(population ~ birth_rate, data =cia_factbook)
summary(model1)
  #What variable is predicting the outcome variable?
    #birth_rate
  #What is the y-intercept?  What is the slope?  
    #y-intercept: 38490437;slope: -329113
  #What is the R-squared for this model?
    #0.003878
  #Is there strong evidence for a real relationship between the predictor and outcome variable?
    # since the p-value is 0.7101, which is greater than 0.05, we don't reject the null hypothesis. 

##Model 2 -- regression model for independent variable death_rate and dependent variable population
model2 <- lm(population ~ death_rate, data =cia_factbook)
summary(model2)
  #What variable is predicting the outcome variable?
    #death_rate
  #What is the y-intercept?  What is the slope?  
    #y-intercept: 32417819; slope: -68180
  #What is the R-squared for this model?
    # -0.004482 
  #Is there strong evidence for a real relationship between the predictor and outcome variable?
    # Since the p-value is 0.981, which is greater than 0.05, we don't reject the null hypothesis. 

  ## HOW TO READ THE OUTPUT of summary(model3)
  # 1) The formula used to describe the model is shown at the top
  # 2) After the formula you find the five-number summary of the residuals.
  # 3) The “Coefficients” table shown next is key; 
    # its first column displays the linear model’s y-intercept (top) and the slope coefficient (bottom)
  # 4) The R-squared value represents how much of the y-axis variable (the dependent/outcome variable)
    # that is explained by the x-axis variable (the independent/predictor variable) explanatory variable
  


########### Graphing the linear regression line over the scatterplot
## Use ggplot() to create a scatterplot with the least squares line laid on top

##Model 1 -- scatterplot and regression line for independent variable birth_rate and dependent variable population
ggplot(cia_factbook, aes(x = birth_rate, y = population, alpha = 0.3)) +
  geom_jitter() +
  theme_bw() +
  geom_smooth(method = "lm", se = FALSE)


##Model 2 -- scatterplot and regression line for independent variable death_rate and dependent variable population
ggplot(cia_factbook, aes(x = death_rate, y = population, alpha = 0.3)) +
  geom_jitter() +
  theme_bw() +
  geom_smooth(method = "lm", se = FALSE)



########### Checking the conditions

#### Condition #1 - Linearity - using residuals plot 
## You want this to look all spread out, with equal (ish) numbers of dots above and below the residual line

ggplot(model1, aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  xlab("Fitted values") +
  ylab("Residuals") +
  theme_bw() 

ggplot(model2, aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  xlab("Fitted values") +
  ylab("Residuals") +
  theme_bw()


#### Condition 2 - Nearly normal residuals - using histogram
## To check this condition, we can look at a histogram of the residuals
ggplot(model1, aes(x = .resid)) +
  geom_histogram(binwidth = 25) +
  xlab("Residuals") +
  theme_bw()

ggplot(model2, aes(x = .resid)) +
  geom_histogram(binwidth = 25) +
  xlab("Residuals") +
  theme_bw()

  ## Based on the skew, shape, and outliers, do the data appear to be roughly normal shaped?


## Condition #3 - constant variance - using residuals plot
## You want this to look all spread out, with equal (ish) numbers of dots above and below the residual line

ggplot(model1, aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  xlab("Fitted values") +
  ylab("Residuals") +
  theme_bw() 

ggplot(model2, aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  xlab("Fitted values") +
  ylab("Residuals") +
  theme_bw()

  ## You want this to look all spread out and random, with no pattern in the residuals (especially no trumpet pattern!)
  ## Is there any apparent pattern in the residuals plot? 
  ## What does this indicate about the linearity of the relationship between the two variables?

