%% Loading conditions
temp = 295; %K
sig.app = 15; %[MPa] applied stress at temperature = temp
matSel = 'resin';

%% Define rectangular test specimens
length = 165; %mm
width = 12.7; %mm
thickness = 8; %mm

% User input not necessary below this line. Ideally.
%% Define material properties
[resin, zero, ten, ninty, fourtyfive, shear] = generateMaterialPropertyTables;

if strcmp(matSel,'resin')
  mat = resin;
elseif strcmp(matSel, 'zero')
  mat = zero;
elseif strcmp(matSel, 'ten')
  mat = ten;
else strcmp(matSel, 'ninty')
  mat = ninty;
end

pos = find(mat.temp == temp);

%% Calculate conditions at the instant load is applied
e.in = sig.app / mat.inst(pos); % e.in = initial strain

% sig.int = internal stress. currently this value is under the initial
% loading conditions
sig.int = e.in * mat.rubber(pos);

% sig.eff = effective stress. currently this is under the initial loading
% conditions
sig.eff = sig.app - sig.int;
