### Environment setup 
library(ROI)
library(ROI.plugin.glpk)

###################### Market research problem ######################################

## Objective function 
obj_fn = c(7.5, 6.9, 6.8, 7.25, 5.5, 6.1)

## LHS --------- repeat 1 for 6 times; repeat pattern (0.85, -0.15) for 3 times; repeat 0 for 4 times
lhs = rbind(c(rep(1,6)),
            c(1,1, rep(0,4)),
            c(0,0,1,1,0,0),
            c(rep(c(0.85,-0.15), 3)),
            c(rep(0,4), 0.8, -0.2))

#### Direction -------- repeat >= for 4 times 
dir = c (rep(">=", 4), "<=")

## RHS
rhs = c (2300, 1000, 600, 0, 0)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs))

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message


############################ Packing problem with bonds ###################################

## Objective
  ## To maximize value 

## Decision variable = whether to load each item A-F --> 0<= A-F <= 1

## Objective function 
  ## 22500a + 24000b + 8000c + 9500d + 11500e + 9750f 

## Constraint 
  ## 7500a + 7500b + 3000c + 3000d + 4000e + 3500 f <= 10000

## Objective function 
obj_fn = c(22500, 24000, 8000, 9500, 11500, 9750)

## LHS --------- repeat 1 for 6 times; repeat pattern (0.85, -0.15) for 3 times; repeat 0 for 4 times
lhs = rbind(c(7500, 7500, 3000, 3000, 4000, 3500))

#### Direction -------- repeat >= for 4 times 
dir = c ("<=")

## RHS
rhs = c (10000)

## LP
lp = OP (maximum = TRUE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         bounds = V_bound(ub = c(rep(1,6))))

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

