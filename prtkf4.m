clc;
clear all;

% Constants
k = 1.38e-23;       % Boltzmann Constant (J/K)
T = 273;            % Temperature (Kelvin)
F = 5;              % Noise Figure (linear, not dB)

% Noise PSD
PSD = k * T * F;    % Power Spectral Density

% Bandwidth range (30 kHz to 40 kHz in steps of 1 kHz)
B = 30e3:1e3:40e3;

% Noise Power in dB
NP = 10*log10(PSD .* B);

% Target BER
BER = 1e-4;

% SNR calculation from BER (for BPSK in AWGN)
x = (1 - 2*BER);
SNR = ((x^2) / (1 - x^2)) * 2;
SNRdB = 10*log10(SNR);

% Link parameters
Gt = 12;   % Tx antenna gain (dB)
Gr = 5;    % Rx antenna gain (dB)
L  = 167;  % Path loss (dB)
M  = 10;   % Margin (dB)
LC = 3;    % Cable loss (dB)

% Required Transmit Power (dB)
Pt = SNRdB - Gt - Gr + L + M + LC + NP;

% Plot
figure;
plot(B, Pt, 'r', 'LineWidth', 2);
xlabel('Bandwidth (Hz)');
ylabel('Transmit Power (dB)');
title('Transmit Power vs Bandwidth');
grid on;
