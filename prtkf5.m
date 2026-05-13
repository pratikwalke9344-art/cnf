clc;
clear;
close all;

L = 4;                        % Number of antennas
SNRdb = 0:2:30;               % SNR range in dB
figure;
hold on;

for l = 1:L
    BER = zeros(1, length(SNRdb));
    for i = 1:length(SNRdb)
        SNR = 10^(SNRdb(i)/10);       % Convert dB to linear
        p = sqrt(SNR / (2 + SNR));    % Probability term
        sum_term = 0;
        for k = 0:l-1
            combi = nchoosek(l-1+k, k);   % Binomial coefficient
            sum_term = sum_term + combi * ((1 + p)/2)^k;
        end
        BER(i) = 0.5 * (1 - p)^l * sum_term;   % BER expression
    end
    semilogy(SNRdb, BER, 'LineWidth', 1.5);    % Log scale plot
end

xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('BER Performance of Multi-Antenna Rayleigh Channel');
legend(arrayfun(@(x) sprintf('l = %d', x), 1:L, 'UniformOutput', false));
grid on;
