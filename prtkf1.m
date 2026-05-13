clc;
clear all;

% Parameters
Hbts = 40;     % BTS antenna height above base
Tbts = 350;    % Terrain elevation at BTS
Htav = 300;    % Average terrain height
Hm = 2;        % Mobile antenna height in meters
f = 900;       % Frequency in MHz (valid for Hata model)
d = 0.5:0.5:15; % Distance in km
Pt = 0.020;    % Transmit power in Watts
Gt = 10;       % BTS antenna gain in dBi

% Effective BTS antenna height
Hb = Hbts + Tbts - Htav;

disp('Hata-Okumura Model');

% Mobile antenna correction factor
aHm = 3.2*(log10(11.75*Hm))^2 - 4.97;

% Path loss parameters
A = 69.55 + 26.16*log10(f) - 13.82*log10(Hb) - aHm;
B = 44.9 - 6.55*log10(Hb);

% Path loss calculation
PL = A + B*log10(d);

% Plot Path Loss
subplot(2,1,1);
plot(d, PL, 'r', 'LineWidth', 2);
title("Hata-Okumura Path Loss Model: Urban", 'fontsize', 14);
xlabel('Distance (km)', 'fontsize', 12);
ylabel('Path Loss (dB)', 'fontsize', 12);
grid on;

% Received Signal Level
Pr = 10*log10(Pt*1000) + Gt - PL;

% Plot Received Signal Level
subplot(2,1,2);
plot(d, Pr, 'b', 'LineWidth', 2);
title("Received Signal Level (Urban)", 'fontsize', 14);
xlabel('Distance (km)', 'fontsize', 12);
ylabel('Received Signal Level (dBm)', 'fontsize', 12);
grid on;
