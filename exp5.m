clc;
clear;
% Inputs that produce the desired output shown in the image:
% Average optical power (dBm)          = -13
% Minimum PIN input power (dBm)        = -24
% Fiber attenuation (dB/km)            = 3.5
% Total connector loss (dB)            = 2
% System margin (dB)                   = 6
% Bandwidth-distance product (MHz.km)  = 400
% LED rise time (ns)                   = 15
% Material dispersion rise time over 6 km (ns) = 21
% Receiver bandwidth (MHz)             = 25
P_tx = input("Enter average optical power (dBm): ");
P_min = input("Enter minimum PIN input power (dBm): ");
alpha = input("Enter fiber attenuation (dB/km): ");
L_C = input("Enter total connector loss (dB): ");
M = input("Enter system margin (dB): ");
BW_dist = input("Enter bandwidth-distance product (MHz.km): ");
t_led = input("Enter LED rise time (ns): ");
t_mat_6 = input("Enter material dispersion rise time over 6 km (ns): ");
BW_rx = input("Enter receiver bandwidth (MHz): ");
P_allow = P_tx - P_min;
L_max = (P_allow - L_C - M) / alpha;
P_loss = alpha * L_max + L_C + M;
P_rx = P_tx - P_loss;
BW_fiber = BW_dist / L_max;
t_fiber = 0.35 / BW_fiber * 1000;
t_mat = t_mat_6 * L_max / 6;
t_rx = 0.35 / BW_rx * 1000;
t_total = sqrt(t_led^2 + t_fiber^2 + t_mat^2 + t_rx^2);
R_max = 0.35 / t_total * 1000;
disp("Maximum link length (km): " + string(L_max));
disp("Received power (dBm): " + string(P_rx));
disp("Total rise time (ns): " + string(t_total));
disp("Maximum data rate (Mbps): " + string(R_max));
if R_max >= 20
    disp("Suitable for 20 Mbps NRZ transmission");
else
    disp("NOT suitable for 20 Mbps NRZ transmission");
end
% Expected output with the inputs above:
% Maximum link length (km): 0.85714
% Received power (dBm): -24
% Total rise time (ns): 20.75
% Maximum data rate (Mbps): 16.8675
% NOT suitable for 20 Mbps NRZ transmission
