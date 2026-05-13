clc;
clear all;

% Given speed in miles per hour
speed_miles = 60;

% Conversion to km/h
speed_km = speed_miles * 1.6;

% Conversion to m/s
speed_meter_per_sec = speed_km * (5/18);

% Speed of light in m/s
c = 3e8;

% Carrier frequency in Hz
fc = 1850e6;

% Doppler Shift frequency calculation
fd = (speed_meter_per_sec / c) * cos(pi/6) * fc;

% Display result
disp(['Doppler Shift Frequency = ', num2str(fd), ' Hz']);
