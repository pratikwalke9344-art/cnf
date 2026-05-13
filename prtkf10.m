% Satellite Link Budget Calculation 
clc; 
clear; 
disp('--- Enter Uplink Parameters ---'); 
Pt_es = input('Earth station transmitter output power (dBW): '); 
backoff_es = input('Earth station back-off loss (dB): '); 
branch_es = input('Earth station branching and feeder losses (dB): '); 
Gt_es = input('Earth station transmit antenna gain (dBi): '); 
atm_loss_up = input('Additional uplink atmospheric losses (dB): '); 
FSL_up = input('Free Space Path Loss (dB): '); 
Gr_sat = input('Satellite Receiver G/T ratio (dB/K): '); 
branch_sat = input('Satellite branching and feeder losses (dB): '); 
Rb_up = input('Bit Rate (bps): '); 
% --- Uplink Calculations --- 
EIRP_up = Pt_es - backoff_es - branch_es + Gt_es; 
C_density_up = EIRP_up - atm_loss_up - FSL_up; 
CNo_up = C_density_up + Gr_sat; 
EbNo_up = CNo_up - 10*log10(Rb_up); 
% --- Enter Downlink Parameters --- 
disp('--- Enter Downlink Parameters ---'); 
Pt_sat = input('Satellite transmitter output power (dBW): '); 
backoff_sat = input('Satellite back-off loss (dB): '); 
branch_sat_tx = input('Satellite branching and feeder losses (dB): '); 
Gt_sat = input('Satellite transmit antenna gain (dBi): '); 
atm_loss_down = input('Additional downlink atmospheric losses (dB): '); 
FSL_down = input('Free Space Path Loss (dB): '); 
Gr_es = input('Earth station receiver G/T ratio (dB/K): '); 
branch_es_rx = input('Earth station branching and feeder losses (dB): '); 
Rb_down = input('Bit Rate (bps): '); 
% --- Downlink Calculations --- 
EIRP_down = Pt_sat - backoff_sat - branch_sat_tx + Gt_sat; 
C_density_down = EIRP_down - atm_loss_down - FSL_down; 
CNo_down = C_density_down + Gr_es - branch_es_rx; 
EbNo_down = CNo_down - 10*log10(Rb_down); 
% --- Combined C/No --- 
CNo_total = -10*log10(10^(-CNo_up/10) + 10^(-CNo_down/10)); 
% --- Results --- 
disp('==============================='); 
disp('Uplink Budget Results:'); 
fprintf('EIRP (Earth Station) = %.2f dBW\n', EIRP_up); 
fprintf('Carrier Power Density at Satellite = %.2f dB\n', C_density_up); 
fprintf('C/No at Satellite = %.2f dB-Hz\n', CNo_up); 
fprintf('Eb/No at Satellite = %.2f dB\n', EbNo_up); 
disp(' '); 
disp('Downlink Budget Results:'); 
fprintf('EIRP (Satellite) = %.2f dBW\n', EIRP_down); 
fprintf('C/No at Earth Station = %.2f dB-Hz\n', CNo_down); 
fprintf('Eb/No at Earth Station = %.2f dB\n', EbNo_down); 
disp(' '); 
fprintf('Total Combined C/No = %.2f dB-Hz\n', CNo_total); 
disp('===============================');
