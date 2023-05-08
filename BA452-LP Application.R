########################## Labor planning ################################
##Environment setup 
library(ROI)
library(ROI.plugin.glpk)

## Objective
## To minimize cost 

## Decision variable 
  ## How many full-time workers to hire and how many part-time workers to hire 
## Objective function 
  ## 100F+32*(S1+S2+S3+S4+S5)

## Constraint 
  ## F<=12
  ## (S1+S2+S3+S4+S5)*4<=0.5*(10+12+14+16+18+17+15+10)
  ## F+S1>=10
  ## F+S1+S2>=12
  ## F+S1+S2+S3>=14
  ## 0.5F+S1+S2+S4>=16
  ## 0.5F+S2+S3+S4+S5>=18
  ## F+S3+S4+S5>=17
  ## F+S4+S5>=15
  ## F+S5>=10

## Objective function 
obj_fn = c(100, rep(32,5))

## LHS
lhs=rbind(c(1, rep(0,5)),
          c(0, rep(4,5)),
          c(1,1,0,0,0,0),
          c(1,1,1,0,0,0),
          c(1,1,1,1,0,0),
          c(0.5,1,1,1,1,0),
          c(0.5,0,1,1,1,1),
          c(1,0,0,1,1,1),
          c(1,0,0,0,1,1),
          c(1,0,0,0,0,1))
  
#### Direction 
dir = c ("<=", "<=", rep(">=",8))

## RHS
rhs = c (10, 0.5*102, 10, 12, 14, 16, 18, 17, 15, 10)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs))

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

############################### Quiz5
##Environment setup 
library(ROI)
library(ROI.plugin.glpk)

## Objective
## To minimize cost 

## Decision variable 
## F1-2,Sa1-3,Su1-2

## Objective function 
## 128*(F1+F2+Sa1+Sa2+Sa3+Su1+Su2)

## Constraint 
## F1>=2
## F1+F2>=10
## F2>=4
## Sa1>=8
## Sa1+Sa2>=12
## Sa2+Sa3>=15
## Sa3>=8
## Su1>=9
## Su1+Su2>=6
## Su2>=3

## Objective function 
obj_fn = c(rep(128, 7))

## LHS
lhs=rbind(c(1,0,rep(0,5)),
          c(1,1,rep(0,5)),
          c(0,1,rep(0,5)),
          c(rep(0,2),1,0,0,rep(0,2)),
          c(rep(0,2),1,1,0,rep(0,2)),
          c(rep(0,2),0,1,1,rep(0,2)),
          c(rep(0,2),0,0,1,rep(0,2)),
          c(rep(0,5),1,0),
          c(rep(0,5),1,1),
          c(rep(0,5),0,1))

#### Direction 
dir = c (rep(">=",10))

## RHS
rhs = c (2,10,4,8,12,15,8,9,6,3)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs))

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

##Environment setup 
library(ROI)
library(ROI.plugin.glpk)

## Objective
## To minimize cost 

## Decision variable 
## S1-6 
## Objective function 
## 64(S1+S1+S3+S4+S5+S6)

## Constraint 
## 

## Objective function 
obj_fn = c(rep(64, 6))

## LHS
lhs=rbind(c(1,0,0,0,0,1),
          c(1,1,0,0,0,0),
          c(0,1,1,0,0,0),
          c(0,0,1,1,0,0),
          c(0,0,0,1,1,0),
          c(0,0,0,0,1,1))

#### Direction 
dir = c (rep(">=",6))

## RHS
rhs = c (7,12,16,14,9,6)

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs))

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message


########################## Production scheduling ################################

## Objective
  ## To minimize production and inventory cost

## Decision variable 
  ## number of units to produce in each time step (P1-3)
  ## number of units to hold in inventory each time step (S1-3) = inventory at the end of the month

## Objective function 
  ## 120*(P1+P2+P3)+6*(S1+S2+S3)

## Constraints
  ## Production constraints 
    ## P1<=230
    ## P2<=230
    ## P3<=230
  ## Demand constraints: DEMAND = inventory at the end of last month + production at this month - sales of this month
    ##1st month: 0+P1-S1 = 180
    ##2nd month: S1+P2-S2 = 220
    ##3rd month: S2+P3-S3 = 240

## Objective function 
obj_fn = c(rep(120,3), rep(6,3))

## LHS --------- 
lhs = rbind(c(1, rep(0,5)),
            c(0,1,rep(0,4)),
            c(0,0,1, rep(0,3)),
            c(1,0,0,-1,0,0),
            c(0,1,0,1,-1,0),
            c(0,0,1,0,1,-1))
              
#### Direction -------- repeat >= for 4 times 
dir = c (rep("<=",3), rep("==",3))
              
## RHS
rhs = c (rep(230,3), 180,220,240)
              
## LP
lp = OP (maximum = FALSE,
        objective = L_objective(obj_fn),
        constraints = L_constraint(lhs, dir, rhs))
              
## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message
    

############################### Problem2 
##Environment setup 
library(ROI)
library(ROI.plugin.glpk)

## Objective
## To minimize cost 

## Decision variable 
## a1-4,sa1-4,b1-4,sb1-4
## Objective function 
## 20a1 + 20a2 + 22a3 + 22a4 + 15b1 + 15b2 + 16.5b3 + 16.5b4 + 0.4*(sa1 + sa2 + sa3 + sa4) + 0.2*(sb1 +sb2 + sb3 + sb4)

## Constraint 
## 

## Objective function 
obj_fn = c(20,20,22,22,15,15,16.5,16.5,rep(0.4,4),rep(0.2,4))

## LHS
lhs=rbind(c(1.6,rep(0,3),0.8,rep(0,3),rep(0,8)),
          c(0,1.6,0,0,0,0.8,0,0,rep(0,8)),
          c(0,0,1.6,0,0,0,0.8,0,rep(0,8)),
          c(0,0,0,1.6,0,0,0,0.8,rep(0,8)),
          c(1,0,0,0,rep(0,4),-1,0,0,0,rep(0,4)),
          c(0,1,0,0,rep(0,4),1,-1,0,0,rep(0,4)),
          c(0,0,1,0,rep(0,4),0,1,-1,0,rep(0,4)),
          c(0,0,0,1,rep(0,4),0,0,1,-1,rep(0,4)),
          c(rep(0,4),1,0,0,0,rep(0,4),-1,0,0,0),
          c(rep(0,4),0,1,0,0,rep(0,4),1,-1,0,0),
          c(rep(0,4),0,0,1,0,rep(0,4),0,1,-1,0),
          c(rep(0,4),0,0,0,1,rep(0,4),0,0,1,-1),
          c(rep(0,8),1,0,0,0,1,0,0,0),
          c(rep(0,8),0,1,0,0,0,1,0,0),
          c(rep(0,8),0,0,1,0,0,0,1,0),
          c(rep(0,8),0,0,0,1,0,0,0,1)
          )

#### Direction 
dir = c (rep("<=",4),rep("==",8),rep("<=",4))

## RHS
rhs = c (rep(2560,4),800,700,1000,1100,1000,1200,1400,1400,rep(3300,4))

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs))

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

##### quiz6
##Environment setup 
library(ROI)
library(ROI.plugin.glpk)

## Objective
## To minimize cost 

## Decision variable 
## a1-4,sa1-4,b1-4,sb1-4
## Objective function 
## 30(a1-a4)+3(sa1-a4)+15(b1-b4)+2(sb1-b4)

## Constraint 
## a1~a4<=540
## b1~b4<=320
## sa1+sb1<=50,sa2+sb2<=50,sa3+sb3<=50,sa4+sb4<=50
  ## Demand constraint 
## a1-sa1>=520
## a2+sa1-sa2>=510
## a3+sa2-sa3>=575
## a4+sa3-sa4>=540

## b1-sb1>=290
## b2+sb1-sb2>=320
## b3+sb2-sb3>=330
## b4+sb3-sb4>=300

## Objective function 
obj_fn = c(rep(30,4),rep(15,4),rep(3,4),rep(2,4))

## LHS
lhs=rbind(c(1,0,0,0,rep(0,12)),
          c(0,1,0,0,rep(0,12)),
          c(0,0,1,0,rep(0,12)),
          c(0,0,0,1,rep(0,12)),
          c(rep(0,4),1,0,0,0,rep(0,8)),
          c(rep(0,4),0,1,0,0,rep(0,8)),
          c(rep(0,4),0,0,1,0,rep(0,8)),
          c(rep(0,4),0,0,0,1,rep(0,8)),
          c(1,0,0,0,rep(0,4),-1,0,0,0,rep(0,4)),
          c(0,1,0,0,rep(0,4),1,-1,0,0,rep(0,4)),
          c(0,0,1,0,rep(0,4),0,1,-1,0,rep(0,4)),
          c(0,0,0,1,rep(0,4),0,0,1,-1,rep(0,4)),
          c(rep(0,4),1,0,0,0,rep(0,4),-1,0,0,0),
          c(rep(0,4),0,1,0,0,rep(0,4),1,-1,0,0),
          c(rep(0,4),0,0,1,0,rep(0,4),0,1,-1,0),
          c(rep(0,4),0,0,0,1,rep(0,4),0,0,1,-1),
          c(rep(0,8),1,0,0,0,1,0,0,0),
          c(rep(0,8),0,1,0,0,0,1,0,0),
          c(rep(0,8),0,0,1,0,0,0,1,0),
          c(rep(0,8),0,0,0,1,0,0,0,1)
          )

#### Direction 
dir = c (rep("<=",8),rep("==",8), rep("<=",4))

## RHS
rhs = c (rep(540,4),rep(320,4),520,510,575,540,290,320,330,300,rep(50,4))

## LP
lp = OP (maximum = FALSE,
         objective = L_objective(obj_fn),
         constraints = L_constraint(lhs, dir, rhs))

## Solve 
sol = ROI_solve(lp, solver="glpk")
sol$message

