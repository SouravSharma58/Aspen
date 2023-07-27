function [y1, x1, K] = wilson_flash(T, P, x1_guess, x2_guess, Tc, Pc, omega, alpha)
% Perform flash calculation using Wilson activity coefficient model
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

% Calculate activity coefficients using Wilson equation
ln_gamma1 = -log(x1_guess + alpha(1, 2) * x2_guess) + x2_guess .* (alpha(1, 2) / (x1_guess + alpha(1, 2) * x2_guess) - alpha(2, 1) / (x2_guess + alpha(2, 1) * x1_guess));
ln_gamma2 = -log(x2_guess + alpha(2, 1) * x1_guess) + x1_guess .* (alpha(2, 1) / (x2_guess + alpha(2, 1) * x1_guess) - alpha(1, 2) / (x1_guess + alpha(1, 2) * x2_guess));

% Calculate vapor and liquid phase mole fractions
y1 = x1_guess .* exp(ln_gamma1) .* P1_sat ./ P;
x1 = x1_guess .* exp(ln_gamma1) .* P1_sat ./ P;

% Calculate equilibrium constant
K = y1 ./ x1;

end