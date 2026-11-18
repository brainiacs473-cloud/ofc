clc;
clear;
R = 20;
t_led = 15;
t_mat = 21;
t_mod = 3.9;
BW_rcv = 25;
t_rcv = 350 / BW_rcv;
t_sys = sqrt(t_led^2 + t_rcv^2 + t_mat^2 + t_mod^2);
nrz_rate = 0.7 * 1000 / t_sys;
rz_rate = 0.35 * 1000 / t_sys;
fprintf('Receiver Rise Time: %.2f ns\n', t_rcv);
fprintf('System Rise Time: %.2f ns\n', t_sys);
fprintf('Maximum NRZ Data Rate: %.2f Mbps\n', nrz_rate);
fprintf('Maximum RZ Data Rate: %.2f Mbps\n', rz_rate);
if nrz_rate >= R
    disp('NRZ format is supported');
else
    disp('NRZ format is not supported');
end
if rz_rate >= R
    disp('RZ format is supported');
else
    disp('RZ format is not supported');
end
