####################### Integer Programming #######################

################ Pt.1 
######## Packing problem 
##Environment setup 
library(ROI)
library(ROI.plugin.glpk)

## Objective
## To Maximize value  

## Decision variable -- whether to load each item or not 
## a-f

## Objective function 
## 22500a+24000b+8000c+9500d+11500e+9750f

## Constraint 
  ## Weight constraints 
## 7500a+7500b+3000c+3000d+4000e+3500f<=150000

## Objective function 
obj_fn = c(22500,24000,8000,9500,11500,9750)

## LHS
lhs=rbind(c(7500,7500,3000,3000,4000,3500))

#### Direction 
dir = c ("<=")

## RHS
rhs = c (15000)

## LP
lp = OP (maximum = TRUE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         bounds = V_bound(ub = rep(1,6))) ## decision variables have to be <1

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

######## Packing problem with Binary Programming 
## Objective function 
obj_fn = c(22500,24000,8000,9500,11500,9750)

## LHS
lhs=rbind(c(7500,7500,3000,3000,4000,3500))

#### Direction 
dir = c ("<=")

## RHS
rhs = c (15000)

## LP
lp = OP (maximum = TRUE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("B",6))) ## decision variables are binary 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

?OP
######## Cell Tower Problem 
## Objective
## Minimizing number of towers 

## Decision variable -- whether to install a tower at each location  
## x1-x6 [binary]

## Objective function 
## x1+x2+x3+x4+x5+x6

## Constraint 
## A: x1+x6>=1
## B: x1+x2>=1
## C: x2+x3>=1
## D: x1+x3+x6>=1
## E: x3+x4+x5>=1
## F: x3+x4+x6>=1
## G: x2+x5>=1
## H: x4+x5>=1

## Objective function 
obj_fn = c(rep(1,6))

## LHS
lhs=rbind(c(1,rep(0,4),1),
          c(1,1,rep(0,4)),
          c(0,1,1,rep(0,3)),
          c(1,0,1,0,0,1),
          c(0,0,1,1,1,0),
          c(0,0,1,1,0,1),
          c(0,1,0,0,1,0),
          c(0,0,0,1,1,0))

#### Direction 
dir = c (rep(">=",8))

## RHS
rhs = c (rep(1,8))

## LP
lp = OP (maximum = FALSE, ## Minimize
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("B",length(obj_fn)))) ## for pure binary only  

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

################ Pt.2 
###### Mixed integer programming (Fixed & variable cost)

## Objective
  ## To minimize fixed and variable cost   

## Decision variable -- whether to load each item or not 
  ## Whether to expand to locations A-C: a1, b1, c1 (binary)
  ## How much to produce at each location: a2, b2, c2 (integer)

## Objective function 
## 340000a1+270000b1+290000c1+32a2+33b2+30c2

## Constraints
## If we expand at A (a1=1), a2<=21000; If we don't expand at A(a1=0), a2=0
  ## a2<=21000a1--> 21000a1-a2>=0
  ## 20000b1-b2>=0
  ## 19000c1-c2>=0
## a2+b2+c2>=38000

## Objective function 
obj_fn = c(340000,270000,290000,32,33,30)

## LHS
lhs=rbind(c(21000,0,0,-1,0,0),
          c(0,20000,0,0,-1,0),
          c(0,0,19000,0,0,-1),
          c(0,0,0,1,1,1))

#### Direction 
dir = c (rep(">=",4))

## RHS
rhs = c (0,0,0,38000)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("B",3),rep("I",3))) #first three are binary and last three are integer 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

#### Integer Programming 1 
## Objective
  ## To maximize reach   

## Decision variable -- how many ads to place 
  ## TV: a = how many TV spot to place
  ## Daily newspaper: b = how many DN spot to place
  ## Radio spot (30s): c = how many Radio spot to place
  ## Radio spot (1min): d = how many Radio spot to place


## Objective function 
## 5000a+8500b+2400c+2800d

## Constraints
  ## Total budget is 8000
## 800a+925b+290c+380d<=8000
  ## At least 5 radio spots be placed each week 
## c+d>=5
  ## No more than $1800 spent on radio every week
## 290c+380d<=1800
## a<=12
## b<=5
## c<=25
## d<=20

## Objective function 
obj_fn = c(5000,8500,2400,2800)

## LHS
lhs=rbind(c(800,925,290,380),
          c(0,0,1,1),
          c(0,0,290,380),
          c(1,0,0,0),
          c(0,1,0,0),
          c(0,0,1,0),
          c(0,0,0,1))

#### Direction 
dir = c ("<=",">=","<=",rep("<=",4))

## RHS
rhs = c (8000,5,1800,12,5,25,20)

## LP
lp = OP (maximum = TRUE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs), ## bounds = V_bound (ub = c(12,5,25,20)),
         types = c(rep("I",4))) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

#### Practice Problem 1
## Objective
## To maximize NPV

## Decision variable -- whether or not to invest on each project   
## a,b,c


## Objective function 
## 25000a+18000b+32000c

## Constraints
## 8000a+6000b+12000c<=20000
## 7000a+4000b+8000c<=16000

## Objective function 
obj_fn = c(25000,18000,32000)

## LHS
lhs=rbind(c(8000,6000,12000),
          c(7000,4000,8000))

#### Direction 
dir = c ("<=","<=")

## RHS
rhs = c (20000,16000)

## LP
lp = OP (maximum = TRUE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("B",3))) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message


#### Practice Problem 2 [pure integer]
## Objective
## To maximize annual passenger-carrying capability 

## Decision variable --    
## x = how many 757 to buy 
## y = how many 767 to buy 


## Objective function 
## 0.125x+0.081y

## Constraints
## x+y<=17
## 80x+110<=1600
## x/x+y>=1/3 --> 3x>=x+y --> 2x-y>=0
## 0.8x+0.5y<=8

## Objective function 
obj_fn = c(0.125,0.081)

## LHS
lhs=rbind(c(1,1),
          c(80,110),
          c(2,-1),
          c(0.8,0.5))

#### Direction 
dir = c ("<=","<=",">=","<=")

## RHS
rhs = c (17,1600,0,8)

## LP
lp = OP (maximum = TRUE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("I",2))) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

#### Practice Problem 3 [pure integer]
## Objective
## To maximize revenue  

## Decision variable    
## x = # surgical beds 
## y = # non-surgical beds 


## Objective function 
  ## For surgical patients: 360/5=72 patients/bed --> 72*1515 = 109080/bed
  ## For non-surgical patients: 360/8=45 patients/bed --> 45*2280 = 102600/bed
## 109080x+102600y


## Constraints
## 72*2.6x+45*3.1y<=15000
## 72*2x+45*1y<=7000
## x+y<=90
## 72x<=2800

## Objective function 
obj_fn = c(109080,102600)

## LHS
lhs=rbind(c(187.2,139.5),
          c(144,45),
          c(1,1),
          c(72,0))

#### Direction 
dir = c (rep("<=",4))

## RHS
rhs = c (15000,7000,90,2800)

## LP
lp = OP (maximum = TRUE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("I",2))) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

############# Group project 

## Objective function 
obj_fn = c(250,130,61,180,95,40,0,33)

## LHS
lhs=rbind(
          c(1, 0, 0, 1, 0, 0, 0, 0),
          c(0, 1, 0, 0, 1, 0, 0, 0),
          c(0, 0, 1, 0, 0, 1, 0, 0),
          c(250,130,61,0,0,0,-500,0))

#### Direction 
dir = c (rep(">=",4))

## RHS
rhs = c (60, 72, 72, 0)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("I",8))) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message
sol$status

########## Quiz 8
## Objective function 
obj_fn = c(37.7, 43.4, 33.3, 29.2, 32.9, 33.1, 28.5, 26.4, 33.8, 42.2,38.9,29.6,37,34.7,30.4,28.5,34.4,41.8,32.8,31.1)

## LHS
lhs=rbind(c(1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0),
          c(0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0),
          c(0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0),
          c(0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1),
          c(1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
          c(0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0),
          c(0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0),
          c(0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0),
          c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1))

#### Direction 
dir = c (rep("<=",9))

## RHS
rhs = c (rep(1,9))

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("B",20)))

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message


#### Practice Problem 4 [mix]
## Objective
## To minimize cost  

## Decision variable    
## m1-3 = whether to start at 6am for 3 generators 
## x1-3 = how much power to produce between 6am and 2pm
## a1-3 = whether to start at 2pm 
## y1-3 = how much power to produce between 2pm and 10pm 


## Objective function 
## 6000m1+5000m2+4000m3+8x1+9x2+7x3+6000a1+5000a2+4000a3+8y1+9y2+7y3


## Constraints
## A generator is turned on at most once in a day 
  ## If m1=1 (turned on in the morning), then a1 has to be 0 (it can't be turned on in the afternoon again)
  ## If a1=1 (turned on in the morning), then m1 has to be 0 (it can't be turned on in the afternoon again)
  ## m1 and a1 can be 0 (it is not turned on at all)
  ## --> m1+a1<=1, m2+a2<=1, m3+a3<=1
## If a generator is on in the morning, then it can produce energy up to its capacity 
  ## If m1=1, x1<=2400
  ## If m1=0, x1=0
  ## --> x1<=2400m1, x2<=2100m2, x3<=3300m3
## If a generator is on in the afternoon, then it can produce energy up to its capacity --> either turned on in afternoon or in the morning
  ## If m1=1, then y1<=2400
  ## If a1=1, then y1<=2400
  ## If m1 and a1 = 0, y1=0
  ## --> y1<=2400(m1+a1), y2<=2100(m2+a2), y3<=3300(m3+a3)
## If a generator is on in the morning, some power must be generated then 
  ## x1>=m1, x2>=m2, x3>=m3
## Demand constraints
  ## x1+x2+x3>=3200
  ## y1+y2+y3>=5700

## Objective function 
obj_fn = c(6000,6000,5000,5000,4000,4000,8,8,9,9,7,7)
  #m1,a1,m2,a2,m3,a3,x1,y1,x2,y2,x3,y3

## LHS
lhs=rbind(c(1,1,rep(0,10)), ## m1+a1<=1
          c(0,0,1,1,rep(0,8)), ## m2+a2<=1
          c(0,0,0,0,1,1,rep(0,6)), ## m3+a3<=1
          c(1,rep(0,5),-1,rep(0,5)), ## [new] m1-x1<=0
          c(0,0,1,rep(0,5),-1,rep(0,3)), ## [new] m2-x2<=0
          c(0,0,0,0,1,rep(0,5),-1,0), # [new] #m3-x3<=0
          c(2400, rep(0,5),-1,rep(0,5)), ## x1<=2400m1 --> 2400m1-x1>=0
          c(0,0,2100,rep(0,5),-1,rep(0,3)), ## 2100m2-x2>=0
          c(0,0,0,0,3300,rep(0,5),-1,0), ## 3300m3-x3>=0
          c(2400,2400, rep(0,5),-1,rep(0,4)), ## 2400m1+2400a1-y1>=0
          c(0,0,2100,2100,rep(0,5),-1,0,0), ## 2100m2+2100a2-y2>=0
          c(0,0,0,0,3300,3300,rep(0,5),-1), ## 3300m3+3300a3-y3>=0
          c(rep(0,6),1,0,1,0,1,0), ## x1+x2+x3>=3200
          c(rep(0,6),0,1,0,1,0,1)) ## y1+y2+y3>=5700
          

#### Direction 
dir = c (rep("<=",6), rep(">=",8))

## RHS
rhs = c (1,1,1,rep(0,9),3200,5700)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs),
         types = c(rep("B",6),rep("I",6))) 

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message
    
  ## Whether to start at 6am | How much power to produce | Whether to start at 2pm | How much power to produce 
## Generator1:      0,                        0,                    1,                          2400
## Generator2:      0,                        0,                    0,                            0
## Generator3:      1,                      3200,                   0,                          3300
