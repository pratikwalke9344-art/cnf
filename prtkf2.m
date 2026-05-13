clc;
clear all;

% Number of bits (not used in analytical formula, relevant for simulation)
N = 1000000;

% SNR range in dB
SNRdb = 0:50;

% Preallocate BER array
BER = zeros(size(SNRdb));

% Compute BER for each SNR
for k = 1:length(SNRdb)
    SNR = 10^(SNRdb(k)/10); % Convert dB to linear
    BER(k) = 0.5 * (1 - sqrt(SNR/(2+SNR))); % BPSK in Rayleigh fading
end

% Convert BER to dB if desired
BERdb = 10*log10(BER);

% Plot BER vs SNR (log scale is standard)
figure;
semilogy(SNRdb, BER, 'b-o', 'LineWidth', 2);
grid on;
xlabel('SNR (dB)', 'fontsize', 12);
ylabel('Bit Error Rate (BER)', 'fontsize', 12);
title('BER vs SNR for BPSK in Rayleigh Fading', 'fontsize', 14);
