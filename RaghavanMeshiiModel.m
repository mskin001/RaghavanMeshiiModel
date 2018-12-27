%% Loading conditions
temp = 295; %K
sApp = 15; %[MPa] applied stress at temperature = temp
matSel = 'resin';
k = 1.38064852e-23; %boltzmann's constant
t = linspace(1,1000,1);
deg = NaN;

%% Define rectangular test specimens
oal = 165; %mm
width = 12.7; %mm
thickness = 8; %mm

%% Preallocate space
s = zeros(t,3); % THe columns are [S11, S22, S33]


% User input not necessary below this line. Ideally.
% Notation: _Ini = initial condition for _ term
%           _Int = internal condition for _ term.
if deg ~= 90 && deg ~= 0 && ~isnan(deg)
  error('This fiber angle as not implemented. Acceptable deg are NaN, 90, 0');
end

%% Define material properties
[resin, zero, ten, ninty, fourtyfive, shear] = generateMaterialPropertyTables;

if strcmp(matSel,'resin')
  mat = resin;
elseif strcmp(matSel, 'zero')
  mat = zero;
elseif strcmp(matSel, 'ten')
  mat = ten;
else
  mat = ninty;
end

pos = find(mat.temp == temp);

%% Calculate initial loading conditions.
% eIni = initial strain in the loading direction (e_11)
eIni = sApp/mat.inst(pos);
% sInt = internal stress. currently this value is under the initial
% loading conditions
sInt = eIni .* mat.rubber(pos);
% sEffIni = effective initial stress. currently this is under the initial loading
% conditions
sEffIni = sApp - sInt;

%% Find the initial creep rate
% Find activation volume
nu.in = mat.temp(pos) * mat.cl * sEffIni^(-mat.d); % initial activation volume
% calculate initial B and beta values based on temperature and applied stress
b.in = mat.BRatio / (mat.beta(pos,2) * temp);
% calculate initial strain rate
eRate.int = b.in * sEffIni * (-log(sEffIni/sEffIni))^(1-1/mat.beta(pos,2))*...
            exp((mat.ae/(k*temp))) * sinh((nu.in*sEffIni)/(k*temp));
 % calculate compliance at time t = 0
s(1,:) = findCompliance(mat, eIni, sEffIni, deg);
