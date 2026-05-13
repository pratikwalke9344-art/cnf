% Simulation of OFDM system in an AWGN environment
clear;
clc;

% -------- Simulation parameters ----------------
nSym = 1e4;                  % Number of OFDM Symbols to transmit
EbN0dB = -20:2:8;            % Eb/N0 range in dB

% -------- OFDM Parameters (IEEE Spec) ----------
N   = 64;                    % FFT size (total subcarriers)
Nsd = 48;                    % Number of data subcarriers
Nsp = 4;                     % Number of pilot subcarriers
ofdmBW = 20e6;               % OFDM bandwidth (Hz)

% -------- Derived Parameters -------------------
deltaF   = ofdmBW / N;       % Subcarrier spacing
Tfft     = 1 / deltaF;       % IFFT/FFT period
Tgi      = Tfft / 4;         % Guard interval duration
Tsignal  = Tgi + Tfft;       % OFDM symbol duration
Ncp      = N * Tgi / Tfft;   % Cyclic prefix length
Nst      = Nsd + Nsp;        % Total used subcarriers

nBitsPerSym = Nst;           % For BPSK, bits per symbol = subcarriers

% Convert Eb/N0 to Es/N0
EsN0dB = EbN0dB + 10*log10(Nst/N) + 10*log10(N/(Ncp+N));

errors = zeros(1, length(EsN0dB));
theoreticalBER = zeros(1, length(EsN0dB));

% -------- Monte Carlo Simulation ---------------
for i = 1:length(EsN0dB)
    for j = 1:nSym
        % Transmitter
        s = 2*round(rand(1, Nst)) - 1;   % BPSK symbols

        % IFFT mapping
        X_Freq = [zeros(1,1) s(1:Nst/2) zeros(1,11) s(Nst/2+1:end)];
        x_Time = N/sqrt(Nst) * ifft(X_Freq);

        % Add cyclic prefix
        ofdm_signal = [x_Time(N-Ncp+1:N) x_Time];

        % Channel (AWGN)
        noise = (randn(1, length(ofdm_signal)) + 1i*randn(1, length(ofdm_signal))) / sqrt(2);
        r = sqrt((N+Ncp)/N) * ofdm_signal + 10^(-EsN0dB(i)/20) * noise;

        % Receiver
        r_Parallel = r(Ncp+1:N+Ncp);              % Remove CP
        r_Time = sqrt(Nst)/N * fft(r_Parallel);   % FFT

        % Extract data carriers
        R_Freq = r_Time([(2:Nst/2+1) (Nst/2+13:Nst+12)]);

        % BPSK demodulation
        s_cap = sign(real(R_Freq));
        numErrors = sum(abs(s_cap - s)/2);

        errors(i) = errors(i) + numErrors;
    end

    % Theoretical BER for BPSK in AWGN
    theoreticalBER(i) = 0.5 * erfc(sqrt(10^(EbN0dB(i)/10)));
end

% -------- Results ------------------------------
simulatedBER = errors / (nSym * Nst);

% Plot results
semilogy(EbN0dB, simulatedBER, 'r-o', 'LineWidth', 2);
hold on;
semilogy(EbN0dB, theoreticalBER, 'k*', 'LineWidth', 2);
grid on;
title('BER vs Eb/N0 for OFDM with BPSK over AWGN');
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate (BER)');
legend('Simulated', 'Theoretical');
