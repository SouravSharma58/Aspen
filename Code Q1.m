% Define simulation parameters
Q_in = 5;           % Flow rate of liquid entering the tank (in L/min)
Q_out = 3;          % Flow rate of liquid leaving the tank (in L/min)
initial_volume = 10; % Initial volume of liquid in the tank (in L)
time_step = 0.1;    % Time step size (in minutes)
simulation_duration = 60; % Simulation duration (in minutes)

% Initialize variables
time = 0:time_step:simulation_duration;   % Time vector
volume = zeros(size(time));               % Liquid volume vector

% Set initial condition
volume(1) = initial_volume;

% Perform simulation
for i = 2:length(time)
    % Calculate volume change using the mass balance equation
    volume_change = (Q_in - Q_out) * time_step;
    
    % Update liquid volume for the current time step
    volume(i) = volume(i-1) + volume_change;
    
    % Ensure non-negative volume (volume cannot be negative)
    volume(i) = max(volume(i), 0);
end

% Plot the liquid level over time
plot(time, volume, 'b', 'LineWidth', 2);
xlabel('Time (min)');
ylabel('Liquid Volume (L)');
title('Liquid Level in the Tank');
grid on;