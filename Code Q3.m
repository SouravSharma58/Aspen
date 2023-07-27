% Step 1: Clear workspace and command window
clc;
clear;

% Step 2: Define binary mixture properties
% Assume the following values for ethanol and water:
Tc = [514.0, 647.3];    % Critical temperature in Kelvin
Pc = [61.4, 220.5];     % Critical pressure in bar
omega = [0.645, 0.344]; % Acentric factor
alpha = [0.2, 0.4; 0.4, 0.2];   % Binary interaction parameters

% Step 3: Define pressure range
P_min = 0.5;    % Minimum pressure in bar
P_max = 2.0;    % Maximum pressure in bar
P_range = P_min:0.1:P_max;  % Pressure range in bar

% Step 4: Perform flash calculations
x_ethanol = 0.6;  % Mole fraction of ethanol
x_water = 0.4;    % Mole fraction of water

y_ethanol = zeros(size(P_range));
for i = 1:length(P_range)
    T = 90;  % Constant temperature in Celsius
    P = P_range(i);

    % Flash calculation
    [y_ethanol(i), ~, ~] = nrtl_flash(T + 273.15, P, x_ethanol, x_water, Tc, Pc, omega, alpha);
end

% Step 5: Plot P-xy diagram
figure;
plot(y_ethanol, P_range, 'b', 'LineWidth', 2);
hold on;
plot(x_ethanol, P_range, 'r', 'LineWidth', 2);
grid on;
xlabel('Ethanol Mole Fraction');
ylabel('Pressure (bar)');
legend('Vapor Phase', 'Liquid Phase');
title('P-xy Diagram');

% Step 6: Define temperature range
T_min = 50;    % Minimum temperature in Celsius
T_max = 100;   % Maximum temperature in Celsius
T_range = T_min:1:T_max;  % Temperature range in Celsius

% Step 7: Perform flash calculations
y_ethanol = zeros(size(T_range));
for i = 1:length(T_range)
    T = T_range(i);
    P = 1.013;  % Constant pressure in bar

    % Flash calculation
    [y_ethanol(i), ~, ~] = nrtl_flash(T + 273.15, P, x_ethanol, x_water, Tc, Pc, omega, alpha);
end

% Step 8: Plot T-xy diagram
figure;
plot(y_ethanol, T_range, 'b', 'LineWidth', 2);
hold on;
plot(x_ethanol, T_range, 'r', 'LineWidth', 2);
grid on;
xlabel('Ethanol Mole Fraction');
ylabel('Temperature (°C)');
legend('Vapor Phase', 'Liquid Phase');
title('T-xy Diagram');