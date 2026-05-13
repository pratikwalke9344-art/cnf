clear all;
clc;

N = 1e6;                       % Number of input bits
EbN0dB = -5:1:27;              % Eb/N0 range in dB

% Generate random binary data
data = rand(1,N) > 0.5;        % Uniform random 0s and 1s
bpskModulated = 2*data - 1;    % Map 0 -> -1, 1 -> +1

M = 2;                         % Constellation points for BPSK
Rm = log2(M);                  % Bits per symbol
Rc = 1;                        % Code rate (no coding)

BER = zeros(1,length(EbN0dB)); % Placeholder for BER values

index = 1;
for k = EbN0dB
    EbN0 = 10^(k/10);                          % Linear scale
    noiseSigma = sqrt(1/(2*Rm*Rc*EbN0));       % Noise std dev
    noise = noiseSigma * randn(1,length(bpskModulated));
    received = bpskModulated + noise;

    % Threshold detection
    estimatedBits = (received >= 0);

    % BER calculation
    BER(index) = sum(xor(data, estimatedBits)) / length(data);
    index = index + 1;
end

% Plot simulated BER
figure;
semilogy(EbN0dB, BER, 'r--o', 'LineWidth', 1.5);
title('Eb/N0 vs BER for BPSK');
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate (BER)');
grid on;
hold on;

% Theoretical BER curve
theoreticalBER = 0.5 * erfc(sqrt(10.^(EbN0dB/10)));
semilogy(EbN0dB, theoreticalBER, 'k-*', 'LineWidth', 1.5);

legend('Simulated','Theoretical');
