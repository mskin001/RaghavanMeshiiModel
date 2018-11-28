%% Loading conditions
temp = 295; %K
sig.app = 15; %[MPa] applied stress at temperature = temp

%% Define rectangular test specimens
length = 165; %mm
width = 12.7; %mm
thickness = 8; %mm


%% Define material properties
[resin, zero, ten, ninty, fourtyfive, shear] = generateMaterialPropertyTables;

%% Calculate initial loading conditions
e.in = sig.app / resin.inst(1); % e.in = initial strain

% sig.int = internal stress. currently this value is under the initial
% loading conditions
sig.int = e.in * resin.rubber(1); 

% sig.eff = effective stress. currently this is under the initial loading
% conditions
sig.eff = sig.app - sig.int; 
