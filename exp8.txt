INTERMODAL DISPERSION
clc;
clear;
close all;
c = 3e8;
L = 1e3;
B_signal = 10e6;
fiber = {'A'; 'B'; 'C'; 'D'};
n1 = [1.50; 1.45; 1.48; 1.487];
n2 = [NaN; 1.43; 1.46; NaN];
NA = zeros(4,1);
NA(1) = 0.4;
NA(4) = 0.275;
NA(2) = sqrt(n1(2)^2 - n2(2)^2);
NA(3) = sqrt(n1(3)^2 - n2(3)^2);
deltaT = (L .* NA.^2) ./ (2 .* n1 .* c);
deltaT_ns = deltaT * 1e9;
BW = 0.44 ./ deltaT;
BW_MHz = BW / 1e6;
Bmax = 1 ./ (2 .* deltaT);
Bmax_Mbps = Bmax / 1e6;
Result = strings(4,1);
for k = 1:4
if B_signal <= Bmax(k)
Result(k) = "Supported";
else
Result(k) = "Not supported";
end
end
ResultsTable = table(fiber, n1, n2, NA, deltaT_ns, ...
BW_MHz, Bmax_Mbps, Result, ...
'VariableNames', {'Fiber', 'n1', 'n2', 'NA', ...
'PulseSpread_ns', 'Bandwidth_MHz', ...
'MaxDataRate_Mbps', '10Mbps_Transmission'});
disp('Modal Pulse Spread and Bandwidth Results:');
disp(ResultsTable);
[maxSpread, idx] = max(deltaT_ns);
fprintf('\nFiber with maximum pulse spread: %s\n', fiber{idx});
fprintf('Maximum pulse spread = %.4f ns\n', maxSpread);
figure;
bar(categorical(fiber), deltaT_ns);
xlabel('Fiber');
ylabel('Modal Pulse Spread (ns)');
title('Modal Pulse Spread for Fibers A-D');
grid on;
figure;
bar(categorical(fiber), BW_MHz);
xlabel('Fiber');
ylabel('Bandwidth (MHz)');
title('Bandwidth for Fibers A-D');
grid on;
MATERIAL DISPERSION
clc;
clear;
close all;
lambda = 1300;
Dm = 3.5;
L = 5;
delta_lambda = 2;
delta_T = abs(Dm) * L * delta_lambda;
delta_T_ns = delta_T / 1000;
delta_T_sec = delta_T * 1e-12;
Bmax = 1 / (2 * delta_T_sec);
Bmax_Mbps = Bmax / 1e6;
fprintf('MATERIAL DISPERSION RESULTS\n');
fprintf('---------------------------\n');
fprintf('Operating wavelength = %.0f nm\n', lambda);
fprintf('Material dispersion coefficient = %.2f ps/(nm.km)\n', Dm);
fprintf('Fiber length = %.2f km\n', L);
fprintf('Spectral width = %.2f nm\n', delta_lambda);
fprintf('\nPulse broadening = %.2f ps\n', delta_T);
fprintf('Pulse broadening = %.3f ns\n', delta_T_ns);
fprintf('Maximum NRZ bit rate = %.2f Mbps\n', Bmax_Mbps);
fiber_length = 0:0.5:10;
pulse_broadening = abs(Dm) .* fiber_length .* delta_lambda;
figure;
plot(fiber_length, pulse_broadening, 'b-o', ...
'LineWidth', 1.5, 'MarkerSize', 5);
xlabel('Fiber Length (km)');
ylabel('Pulse Broadening (ps)');
title('Material Dispersion vs Fiber Length');
grid on;
