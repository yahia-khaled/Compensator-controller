# Compensator Controller Design

This project involves designing a compensator using MATLAB's SISOtool to achieve a specified phase margin while meeting steady-state error requirements. The compensator is tuned to balance the trade-offs between steady-state accuracy and system stability.

## Project Description
Given a control loop, the goal is to design a compensator and select appropriate controller values and proportional gain to achieve:
- Desired steady-state error.
- Sufficient phase margin for stability.

The challenge lies in determining the optimal parameters to meet these objectives.

## Simulation Tool and Version
- MATLAB R2021a
- Control System Toolbox
- SISOtool

# project code run procedure
1. convert control loop transfer function from s-domain to z-domain
2. convert control loop transfer function from z-domain to w-domain to enable view bode plot and step response
3. plot loop response without adding proportional gain
4. adding proportional gain to loop and plot new response, observe that error steady state is acheived but phase margin is lost.
5. give function of `get_pole_zero_for_lead_compensator` to get initial values of pole-zero location that will be used in sisotool.
6. open sisotool and use the provided zero-pole location for design compensator.
7. tune the zero-pole location to get required phase margin.
8. plot step response and get bode plot of control loop transfer function after adding compensator function obtained in sisotool.
9. plot new step response and bode plot of control loop after including compensator in loop. 
