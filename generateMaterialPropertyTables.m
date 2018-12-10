function [resin, zero, ten, ninty, fourtyfive, shear] = generateMaterialPropertyTables
% These material properies are found in tables 1-10 in the paper "Creep of
% polymer composites" by Raghavan and Meshii for use in the creep model of
% the same name. Detailes about the meausrement of these properties can be
% found in the paper.

%% Poisson's Ratio
resin.nu = 0.31;
%% Glass transition temperature in K. Table 1
resin.Tg = 512;
zero.Tg = 517;
ten.Tg = 523;
ninty.Tg = 518;
fourtyfive.Tg = 518;

%% Tan(delta_max) at frequency of 1 Hz. Table 1
resin.tand = 0.627;
zero.tand = 0.221;
ten.tand = 0.131;
ninty.tand = 0.208;
fourtyfive.tand = 0.242;

%% Activation energy in kJ/mol. Table 1
resin.ae = 493;
zero.ae = 504;
ten.ae = 543;
ninty.ae = 495;
fourtyfive.ae = 562;

%% Experimental tempearatures by fiber orientation
% The order of temperature measurements corresponds to those in tables 2-6
% in the paper. In all material property vectors the (1,1) positions always
% correspond as shown in the tables.

resin.temp = [295 373 403 433 463 552];
zero.temp = [295 373 403 433 463 563];
ten.temp = [295 373 403 433 463 563];
ninty.temp = [295 373 403 433 463 558];
shear.temp = [295 373 403 433 463 563];
%% Instantaneous modulous for each fiber orientation at experimental
%  temperatures.
resin.inst = [6.50 5.38 4.93 4.48 4.03];
zero.inst = [200.0 196.0 195.6 193.1 191.6];
ten.inst = [146.44 133.26 129.18 124.80 120.44];
ninty.inst = [14.00 13.20 12.92 12.62 9.52];
shear.inst = [14.73 13.57 12.99 12.55 12.12];

%% Rubbery modulous for each fiber orientation
resin.rubber = [0.034 0.043 0.046 0.049 0.053 0.063];
zero.rubber = [12.7 16.1 17.4 18.7 19.9 24];
ten.rubber = [8.44 10.67 11.53 12.39 13.25 16.11];
ninty.rubber = [0.97 1.22 1.32 1.41 1.51 1.82];
shear.rubber = [0.72 0.90 0.98 1.05 1.12 1.36];

%% Viscous modulous for each fiber orientation
resin.vis = [6.47 5.33 4.88 4.43 3.98];
zero.vis = [187.3 179.9 178.2 174.4 174.4];
ten.vis = [138.00 122.59 117.65 112.42 107.20];
ninty.vis = [13.04 11.98 11.60 11.21 8.01];
shear.vis = [14.02 12.66 12.02 11.51 10.99];


%% Power law constants used for fitting equation 14 in the paper. From
% table 7
resin.cu = 7.2e-22;
resin.cl = 2.6e-22;
resin.d = 1.057;

ninty.cu = 7.2e-22;
ninty.cl = 2.6e-22;
ninty.d = 1.061;

ten.cu = 3.5e-21;
ten.cl = 3.6e-22;
ten.d = 1.061;

%% B and beta values for fiber angles at various temperatures. All values
% are measured at temperature in order 295, 373, 403, 433. These values are
% from tables 8-10.

% The resin only values are found at a creep stress of 5 and 15 MPa. The
% first column corresponds to 5 MPa and the second column to 15 MPa.
resin.beta = [NaN 0.061 0.066 0.059; 0.073 0.138 0.155 0.217]';
resin.BRatio = [NaN 1.04e8 1.29e8 1.09e9; 2.99e31 2.89e31 2.98e31 3.07e31]';

% The 90 deg values are found at a creep stress of 15 and 29.7 MPa except
% for BRatio(1,2) beta(1,2) which is at a creep stress of 42 MPa
ninty.beta = [0.048 0.082 0.072 0.084; 0.067 0.113 0.126 0.135]';
ninty.BRatio = [6.43e20 9.6e21 9.0e20 3.96e20; 7.14e27 8.75e27 7.52e27 6.21e27]';

% The 10 deg values are found at a creep stress of 15 and 28.9 MPa.
% beta(1,2) and BRatio(1,2) are at 42 MPa. beta(2,2) and BRatio(2,2) are at
% 66.3 MPa. beta(5,2) and BRatio(5,2) are at 20.8 MPa.
ten.beta = [0.050 NaN NaN 0.124 0.122; 0.053 0.068 0.086 0.096 0.111]';
ten.BRatio = [4.22e37 NaN NaN 4.19e37 4.57e37; 2.26e47 9.3e58 1.28e41 1.27e41 4.35e39]';


end
