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

## How to Run the Project
1. Convert the control loop transfer function from the s-domain to the z-domain.
2. Transform the transfer function from the z-domain to the w-domain to enable Bode plot and step response analysis.
3. Plot the loop response without proportional gain.
4. Add proportional gain, plot the new response, and observe changes in steady-state error and phase margin.
5. Use the `get_pole_zero_for_lead_compensator` function to obtain initial pole-zero locations.
6. Open SISOtool, input the pole-zero locations, and design the compensator.
7. Tune the compensator to achieve the required phase margin.
8. Plot the step response and Bode plot of the compensated system.

## Example Output
![Step Response](path/to/step_response_image.png)

## Licensing
This project is licensed under [MIT License](LICENSE).

## Contact
For questions or issues, please contact [your_email@example.com].
