clc;
clear all;

% Parameters
Pb = 0.02;          % Blocking probability (not used here)
Ao = 0.04;          % Area per user (km^2)
r = 0.5:0.2:1.5;    % Hexagon radius (km)
AreaCity = 603;     % City area (km^2)
A = 38.4;           % Traffic intensity (Erlangs)
ang = pi/6;         % 30 degrees

% Users per cell
NoUsersPerCell = A / Ao;
disp(['Users per cell = ', num2str(NoUsersPerCell)]);

% Hexagon geometry
len1 = tan(ang) .* r;
len = 2 .* len1;
disp('Hexagon side lengths:');
disp(len);

AreaHexagon = 3 .* r .* len;
disp('Hexagon areas:');
disp(AreaHexagon);

% Number of cells
NoCells = AreaCity ./ AreaHexagon;
disp('Number of cells:');
disp(NoCells);

% Total users supported
NoUser = NoUsersPerCell .* NoCells;
disp('Total users supported:');
disp(NoUser);

% Plot
plot(r, NoUser, 'b-o', 'LineWidth', 2);
xlabel('Radius of Hexagon (km)');
ylabel('Total Users in City');
title('Graph for Estimating Total Number of Users in City');
grid on;
