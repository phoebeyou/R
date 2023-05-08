## Meta info##
## Author: Phoebe You
## Contact: phoebeyou.2023@gmail.com
## Subject: Introduction to ROI+Sensitivity analysis 


## Initial Setup 
install.packages("ROI")
install.packages("ROI.plugin.glpk")

## Environment setup = need to be done everytime 
library(ROI)
library(ROI.plugin.glpk)

## Problem 1
## Maximize 50x+70y s.j.
## 3x+4y<=240
## x+2y<=100

## Objective Function 
obj_fn = c(50,70)

## Constraints LHS
lhs = rbind(c(3,4),
            c(1,2))

## Constraint Direction 
dir = c("<=","<=")

##Constraint RHS
rhs = c(240,100)

lp = OP(maximum = TRUE, 
        objective = L_objective(obj_fn),
        constraints = L_constraint(lhs, dir, rhs))
## Solution 
sol = ROI_solve(lp, solver="glpk")
sol$message 


#Auxiliary primal&dual
  #240 hours available in assembly shop -- if an extra hour is available, profit increases by $15
  #100 hours available in polishing shop -- if an extra hour is available, profit increases by $5


## Problem 2
## Maximize 1500x+2800y s.j.
## 300x+800y<=12000
## 2250x+3500y<=60000

## Objective Function 
obj_fn2 = c(1500,2800)

## Constraints LHS
lhs2 = rbind(c(300,800),
            c(2250,3500))

## Constraint Direction 
dir2 = c("<=","<=")

##Constraint RHS
rhs2 = c(12000,60000)

lp2 = OP(maximum = TRUE, 
        objective = L_objective(obj_fn2),
        constraints = L_constraint(lhs2, dir2, rhs2))
## Solution 
sol2 = ROI_solve(lp2, solver="glpk")
sol2$message 

## Sensitivity analysis 
  ## Monthly earnings will increase by 1.4 dollar if the space is increase by 1 square feet
  ## Monthly earnings will increase by 0.48 dollar if the budget is increased by 1 dollar 
