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

%-------------------------------------------------------------------------------
% User input not necessary below this line. Ideally.
%-------------------------------------------------------------------------------

%% Preallocate space
s = zeros(t,3); % Compliance matrix at all times, the columns are [S11, S22, S33]
sInt = zeros(t,3); % Internal stress at all time during the experiment
sEff = zeros(t,3); % Effective stress at all times during the experiment
eRate = zeros(t,3); % Creep rate at all times during the experiment

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
[eIni, sInt(1), sEff(1)] = currentLoad(mat, pos, sApp)

%% Find the initial creep rate
% Find activation volume
nu.in = mat.temp(pos) * mat.cl * sEff(1)^(-mat.d); % initial activation volume
% calculate initial B and beta values based on temperature and applied stress
b.in = mat.BRatio / (mat.beta(pos,2) * temp);
% calculate initial strain rate
eRate(1) = b.in * sEff(1) * (-log(sEff(1)/sEff(1)))^(1-1/mat.beta(pos,2))*...
            exp((mat.ae/(k*temp))) * sinh((nu.in*sEff(1))/(k*temp));

 % calculate compliance at time t = 0
s(1,:) = findCompliance(mat, eIni, sEff(1), deg);

for k = 2:length(t)
  %Calculate stress, strain, and compliance for each time step



end
