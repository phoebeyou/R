####################### Goal Programming #######################

##Environment setup 
library(ROI)
library(ROI.plugin.glpk)

################ Product mix with a profit goal 
###### Goal programming with 1 goal 
## Goals --> profit=30

## Objective = minimize deviation from goal 

## Variables 
  ## Decision variables 
## How much of each product to make: x, y
  ## Deviational variables 
## Goal 1: g1p=positive deviation from goal1, g1n=negative deviation from goal1

## Objective function 
  ## 0x+0y+g1p+g1n

## Constraints 
  ## 2x+3y<=12
  ## 6x+5y<=30
  ## 7x+6y=30+g1p-g1n --> 7x+6y-g1p+g1n=30

## Objective function 
obj_fn = c(0,0,1,1)

## LHS
lhs=rbind(
  c(2,3,0,0),
  c(6,5,0,0),
  c(7,6,-1,1))

#### Direction 
dir = c (rep("<=",2),"==")

## RHS
rhs = c (12,30,30)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs)) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message
  ## Deviation=0, produce 4.2857 units of x

###### Goal programming with multiple goals
###### Goal programming with 2 goal 
## Goals
  ## Profit=30
  ## Utilize hours available in DeptA

## Objective = minimize deviation from goal 

## Variables 
  ## Decision variables 
## How much of each product to make: x, y
  ## Deviational variables 
## Goal 1: g1p=positive deviation from goal1, g1n=negative deviation from goal1
## Goal 2: g2p, g2n

## Objective function 
## 0x+0y+g1p+g1n+g2p+g2n

## Constraints 
## 6x+5y<=30
## 7x+6y=30+g1p-g1n --> 7x+6y-g1p+g1n=30
## 2x+3y=12+g2p-g1n --> 2x+3y-g2p+g2n=12

## Objective function 
obj_fn = c(0,0,1,1,1,1)

## LHS
lhs=rbind(
  c(6,5,0,0,0,0),
  c(7,6,-1,1,0,0),
  c(2,3,0,0,-1,1))

#### Direction 
dir = c ("<=",rep("==",2))

## RHS
rhs = c (30,30,12)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs)) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

###### Goal programming with 3 goal 
## Goals
  ## Profit=30
  ## Utilize hours available in DeptA --> negative deviation only 
  ## Avoid overtime in DeptB --> positive deviation only 

## Objective = minimize deviation from goal 

## Variables 
## Decision variables 
  ## How much of each product to make: x, y
## Deviational variables 
  ## Goal 1: g1p=positive deviation from goal1, g1n=negative deviation from goal1
  ## Goal 2: g2p, g2n
  ## Goal 3: g3p, g3n

## Objective function 
## 0x+0y+g1p+g1n+0g2p+g2n+g3p+0g3n

## Constraints 
## 7x+6y=30+g1p-g1n --> 7x+6y-g1p+g1n=30
## 2x+3y=12+g2p-g1n --> 2x+3y-g2p+g2n=12
## 6x+5y==30+g3p+g3n --> 6x+5y-g3p+g3n=30

## Objective function 
obj_fn = c(0,0,1,1,0,1,1,0)

## LHS
lhs=rbind(
  c(7,6,-1,1,0,0,0,0),
  c(2,3,0,0,-1,1,0,0),
  c(6,5,0,0,0,0,-1,1))

#### Direction 
dir = c (rep("==",3))

## RHS
rhs = c (30,12,30)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs)) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message
  ## Goal1: achieved
  ## Goal2: achieved 
  ## Goal3: No overutilization and there is underutilization by 4.67 hrs --> avoid overtime achieved

###### Ranked Goal Problem 1
#### Equal priority goals 
## Goals
## Amount of tubing used must not exceed availability --> only positive 
## Profit should be at least $2800 --> only negative 

## Objective = minimize deviation from goal 

## Variables 
## Decision variables 
  ## How much of each product to make: x, y, z
## Deviational variables 
  ## Goal 1: g1p=positive deviation from goal1, g1n=negative deviation from goal1
  ## Goal 2: g2p, g2n


## Objective function 
## 0x+0y+0z+g1p+0g1n+0g2p+g2n

## Constraints 
## 1.2x+1.7y+1.2z<=1000
## 0.8x+0.2y+2.3z<=1200
## 2x+3y+4.5z==2000+g2p-g2n --> 2x+3y+4.5z-g1p+g1n==2000
## 3x+4y+5z==2800+g2p-g2n --> 3x+4y+5z-g2p+g2n==2800

## Objective function 
obj_fn = c(0,0,0,1,0,0,1)

## LHS
lhs=rbind(
  c(1.2,1.7,1.2,rep(0,4)),
  c(0.8,0.2,2.3,rep(0,4)),
  c(2,3,4.5,-1,1,0,0),
  c(3,4,5,0,0,-1,1))

#### Direction 
dir = c ("<=", "<=", rep("==",2))

## RHS
rhs = c (1000,1200,2000,2800)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("I",3),rep("C",4))) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message
  ## Goal1:[1,0] amount of tubing required is exceeded by 1 unit
  ## Goal2: [0,33] profit falls short by 33 units 

#### Ranked priorities  
## Goals
## Amount of tubing used must not exceed availability --> only positive 
## Profit should be at least $2800 --> only negative 

## Objective = minimize deviation from goal 

## Variables 
## Decision variables 
## How much of each product to make: x, y, z
## Deviational variables 
## Goal 1: g1p=positive deviation from goal1, g1n=negative deviation from goal1
## Goal 2: g2p, g2n


## Objective function 
## 0x+0y+0z+10*g1p+0g1n+0g2p+g2n

## Constraints 
## 1.2x+1.7y+1.2z<=1000
## 0.8x+0.2y+2.3z<=1200
## 2x+3y+4.5z==2000+g2p-g2n --> 2x+3y+4.5z-g1p+g1n==2000
## 3x+4y+5z==2800+g2p-g2n --> 3x+4y+5z-g2p+g2n==2800

## Objective function 
obj_fn = c(0,0,0,10,0,0,1)

## LHS
lhs=rbind(
  c(1.2,1.7,1.2,rep(0,4)),
  c(0.8,0.2,2.3,rep(0,4)),
  c(2,3,4.5,-1,1,0,0),
  c(3,4,5,0,0,-1,1))

#### Direction 
dir = c ("<=", "<=", rep("==",2))

## RHS
rhs = c (1000,1200,2000,2800)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("I",3),rep("C",4))) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message
  ##Goal1:[0,0.5] 0.5 units of tubing is leftover 
  ## Goal2: [0,35] profit falls short by 35 units 

#### Ranked Goal Problem 2  
## Goals
  ## Attain a profit as close to $1100 as possible each week 
  ## Avoid underutilization of the firm's production capacity --> only negative matter 

## Objective = minimize deviation from goal 

## Variables 
  ## Decision variables 
## How much of each product to make: x, y
  ## Deviational variables 
## Goal 1: g1p=positive deviation from goal1, g1n=negative deviation from goal1
## Goal 2: g2p, g2n


## Objective function 
## 0x+0y+10g1p+10g1n+0g2p+g2n

## Constraints 
## 10x+15y=11000+g1p-g1n
## x+2y<=1300+g2p-g2n
## x<=600
## y<=400

## Objective function 
obj_fn = c(0,0,10,10,0,1)

## LHS
lhs=rbind(
  c(1,0,rep(0,4)),
  c(0,1,rep(0,4)),
  c(1,2,0,0,-1,1),
  c(10,15,-1,1,0,0))

#### Direction 
dir = c ("<=", "<=", "==", "<=")

## RHS
rhs = c (600,400,1300,11000)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("I",2),rep("C",4))) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

############### Quiz 9 
## Objective function 
obj_fn = c(0,0,0,0,1,0,1,0,1)

## LHS
lhs=rbind(
  c(1,0,0,rep(0,6)),
  c(0,1,0,rep(0,6)),
  c(0,0,1,rep(0,6)),
  c(1,0,0,-1,1,0,0,0,0),
  c(0,1,0,0,0,-1,1,0,0),
  c(8,13,16,0,0,0,0,-1,1))

#### Direction 
dir = c (rep("<=",3),rep("==",3))

## RHS
rhs = c (40,50,60,30,35,1200)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("I",3),rep("C",6))) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

#### Flour Blending Goals 
## Goals = 5 
  ## Protein/100mg = 10mg
  ## Carbs/100mg = 78mg
  ## Fiber zt least 2mg
  ## Fat/100mg = 4mg
  ## Starch 

## Variables 
## Decision variables 
  ## How much of each ingredient to include: x, y, z
## Deviational variables 
  ## Goal 1: g1p=positive deviation from goal1, g1n=negative deviation from goal1
  ## Similarly for goal2-5

## Objective = minimize deviation from goal
## Objective function
## 0x+0y+0z+100*(g1p+g1n)+10*(g2p+g2n+0g3p+g3n)+g4p+g4n+g5p+g5n

## Constraints 
  ## x+y+z=100
  ## 0.5y-z>=0
  ## 0.22+0.06y+0.003z == 10+g1p-g1n
  ## 0.57x+0.8y+0.91z == 78+g2p-g2n
  ## 0.1x+0.042y == 2+g3p-g3n
  ## 0.06x+0.01y+0.001z = Z4+g4p-g4n
  ## 0.1x == 0+g5p-g5n


## Objective function 
obj_fn = c(0,0,0,100,100,10,10,0,10,1,1,1,1)

## LHS
lhs=rbind(
  c(1,1,1,rep(0,10)),
  c(0,0.5,-1,rep(0,10)),
  c(0.22,0.06,0.003,-1,1,rep(0,8)),
  c(0.57,0.8,0.91,0,0,-1,1,rep(0,6)),
  c(0.1,0.042,0,0,0,0,0,-1,1,rep(0,4)),
  c(0.06, 0.01,0.001,0,0,0,0,0,0,-1,1,rep(0,2)),
  c(0.1,0,0,rep(0,8),-1,1))

#### Direction 
dir = c ("==",">=", rep("==",5))

## RHS
rhs = c (100,0,10,78,2,4,0)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs)
) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message




