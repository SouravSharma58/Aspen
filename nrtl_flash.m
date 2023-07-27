% NRTL activity coefficient model function
function [y1, x1, K] = nrtl_flash(T, P, x1_guess, x2_guess, Tc, Pc, omega, alpha)
% Perform flash calculation using NRTL activity coefficient model
% Inputs:
%   T: Temperature (K)
%   P: Pressure (bar)
%   x1_guess, x2_guess: Initial guess for mole fractions
%   Tc, Pc: Critical temperature (K) and pressure (bar)
%   omega: Acentric factor
%   alpha: Binary interaction parameters
% Outputs:
%   y1: Mole fraction of component 1 in the vapor phase
%   x1: Mole fraction of component 1 in the liquid phase
%   K: Equilibrium constant

% Convert pressure from bar to Pa
P = P * 1e5;

% Calculate vapor pressures using Antoine equation
Psat = @(T, A, B, C) exp(A - B ./ (T + C));
P1_sat = Psat(T, 16.5945, 3649.31, 230.918);
P2_sat = Psat(T, 16.3872, 3885.70, 230.170);

% Calculate activity coefficients using NRTL equation
tau = alpha ./ T;
G = exp(-alpha .* tau);
gamma1 = exp(sum(x2_guess .* tau(1, 2) .* G(:, 2) ./ sum(x2_guess .* G(:, 2))));
gamma2 = exp(sum(x1_guess .* tau(2, 1) .* G(:, 1) ./ sum(x1_guess .* G(:, 1))));

% Calculate vapor and liquid phase mole fractions
y1 = x1_guess .* gamma1 .* P1_sat ./ P;
x1 = x1_guess .* gamma1 .* P1_sat ./ P;

% Calculate equilibrium constant
K = y1 ./ x1;

end