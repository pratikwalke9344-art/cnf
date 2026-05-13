% Given discrete delays (in microseconds) 
tau = [0 0.5 1 1.5 2]; 
% Given power in dB 
P_dB = [0 -3 -6 -9 -12]; 
% Convert to linear scale 
P = 10.^(P_dB/10); 
% Mean excess delay 
tau_mean = sum(tau .* P) / sum(P); 
% RMS delay spread 
tau_rms = sqrt(sum(P .* (tau - tau_mean).^2) / sum(P)); 
% Maximum delay spread 
tau_max = max(tau) - min(tau); 
fprintf('Mean Excess Delay = %.4f us\n', tau_mean); 
fprintf('RMS Delay Spread = %.4f us\n', tau_rms); 
fprintf('Max Delay Spread = %.4f us\n\n', tau_max); 
% Plot Discrete PDP 
figure; 
stem(tau, P_dB, 'filled'); 
xlabel('Relative Delay \tau (us)'); 
ylabel('P(\tau) in dB'); 
title('Discrete Power Delay Profile'); 
grid on; 
% Continuous delay axis 
tau_cont = 0:0.5:1000;   % microseconds 
% Exponential PDP model 
tau_rms_exp = 50;        
% RMS delay spread parameter (adjustable) 
P_exp = exp(-tau_cont / tau_rms_exp); 
% Normalize to dB 
P_exp_dB = 10*log10(P_exp / max(P_exp)); 
% Plot Exponential PDP 
figure; 
plot(tau_cont, P_exp_dB, 'LineWidth', 2); 
xlabel('Delay (us)'); 
ylabel('Power (dB)'); 
title('Exponential Power Delay Profile'); 
grid on;
