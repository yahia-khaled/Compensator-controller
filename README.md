# Compensator-controller <br />
design compensator using sisotool in matlab to acheive specified phase margin <br />
# project description <br />
given control loop we need to achieve specified error steady state, so it is required to design compensator controller <br />
the challange is to select appropriate values for controller and proprtional gain to achieve required response.<br />
# simulation tool and version
projects run over matlab R2021a, using sisotool build in matlab that take control loop for design. <br />
# project code run procedure
1. convert control loop transfer function from s-domain to z-domain
2. convert control loop transfer function from z-domain to w-domain to enable view bode plot and step response
3. plot loop response without adding proportional gain
4. adding proportional gain to loop and plot new response, observe that error steady state is acheived but phase margin is lost.
5. give function of get_pole_zero_for_lead_compensator to get initial values of pole-zero location that will be used in sisotool.
6. open sisotool and use the provided zero-pole location for design compensator.
7. tune the zero-pole location to get required phase margin.
8. plot step response and get bode plot of control loop transfer function after adding compensator function obtained in sisotool.
9. plot new step response and bode plot of control loop after including compensator in loop. 



