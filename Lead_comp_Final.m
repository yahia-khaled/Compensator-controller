clc;
clear all;
close all;
% Sampling time
T = 0.1;
% Define the continuous-time process transfer function
Gp = tf(4, [1 2.5 1]);
% Define the continuous-time feedback transfer function
H = tf(1, [0.05 1]);
% Define the Tf before adding the gain
Tf_Orignal = (Gp / (1+ H * Gp) );
% get Loop in w domain while k =1
Loop_w = d2c(c2d(Gp * H,T,'zoh'),'tustin');
FeedForward_w = d2c(c2d(Gp,T,'zoh'),'tustin');
Tf_in_w = (FeedForward_w)/(1+Loop_w);
% plot bode plot for system of k = 1
figure;
margin(Loop_w);
% Get the Step response
figure;
step(Tf_in_w);
legend(strcat('k = ', num2str(1)));
% Get discrete open loop Gain in Z-Domain
GH_Z= c2d(Gp * H , T, 'zoh') ; 
% Get the numerator and denominator of the discretized transfer functions
[num_GH_Z, den_GH_Z] = tfdata(GH_Z, 'v');
% Define symbolic variables
syms K z
% Convert the numeric transfer functions to symbolic forms
GH_loop = poly2sym(num_GH_Z, z) / poly2sym(den_GH_Z, z);
% Compute ESS
Kp = subs(GH_loop, z, 1) * K ;
ess = 1 / ( 1 + Kp) ;
% Solve for K to achieve ESS = 10%
eqn = ess == 0.1;
K = double(solve(eqn, K));
disp('The value of K to achieve ESS = 10% is:');
disp(K);
%% get response of system before compensator
FeedForward_z=c2d(K*Gp,T,'zoh');
Loop_z=c2d(K* Gp * H,T,'zoh');
Tf_in_discrete = FeedForward_z/(1+Loop_z);
Tf_in_discrete = minreal(Tf_in_discrete);

% get Loop in w domain 
Loop_w = d2c(Loop_z,'tustin');
FeedForward_w = d2c(FeedForward_z,'tustin');
Tf_in_w = (FeedForward_w)/(1+Loop_w);
% step response in w domain
figure;
step(Tf_in_w);
legend(strcat('k = ', num2str(K)));
% Gain margin, Phase margin
figure;
margin(Loop_w);

%define required phase margin
PM_req = 50;
%get pole-zero location for compensator
[zero_location,pole_location, phi_max] = get_pole_zero_for_lead_compensator(Loop_w,PM_req);
%open sisotool
% sisotool(Loop_w);
%% design compensator
Gc_w = tf([0.4 1],[0.085 1]);
Gc_z = c2d(Gc_w,T,'tustin');
%observe resposne after adding compensator
Loop_z_new = Loop_z * Gc_z;
FeedForward_z_new = FeedForward_z * Gc_z;
%convert new loop to w domain
Loop_w_new = d2c(Loop_z_new,'tustin');
FeedForward_w_new = d2c(FeedForward_z_new,'tustin');
%step response
Tf_in_w_new = FeedForward_w_new / (1 + Loop_w_new);
figure;
step(Tf_in_w_new);
%bode plot of new response
figure;
margin(Loop_w_new);
%% check Ess
syms  z
% Get the numerator and denominator of the discretized transfer functions
[num_GH_Z, den_GH_Z] = tfdata(Loop_z_new, 'v');
% Convert the numeric transfer functions to symbolic forms
GH_loop = poly2sym(num_GH_Z, z) / poly2sym(den_GH_Z, z);
Kp = subs(GH_loop, z, 1) ;
ess = 1 / ( 1 + Kp) ;
disp('The new value of Ess is in %');
disp(double(ess * 100));
%% check Phase Margin theoretical
omega = 3.62 ;
phase = angle(evalfr(Loop_w_new , 1i * omega )) * 180 /pi ;
PM_theoretical=phase+180;
disp('The theoretical PM is ');
disp(PM_theoretical);
%% Function to calculate pole-zero location of compensator
function [zero_location , pole_location, phi_max] = get_pole_zero_for_lead_compensator(tfElement, PM_required)
%calculate alpha and phi max for design of compensator
[~,Pm] = margin(tfElement);
%calculate phi max with safety factor 10 degree
SF = 10;
phi_max = PM_required - Pm + SF;
%get alpha
alpha = (1-sin(phi_max*(pi/180)))/(1+sin(phi_max*(pi/180)));
% Target magnitude (desired loop gain)
target_gain = 10 * log(alpha); % Specify the desired magnitude
%estimate frequecny at which taget gain exist
[mag, ~ ,wout] = bode(tfElement);
mag = squeeze(mag);
% Find the frequency closest to the target gain
Wgc_new = interp1(20*log10(mag), wout,target_gain);              
% get gamma
gamma = 1/(sqrt(alpha) * Wgc_new);
% calculate pole
pole_location = 1 / (gamma * alpha);
%zero location
zero_location = 1 /(gamma);
% print zero-pole location
fprintf("zero location will be : %f \npole location will be : %f \n",zero_location,pole_location);
end
