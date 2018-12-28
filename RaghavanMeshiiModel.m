%% Loading conditions
temp = 295; %K
sApp = 15; %[MPa] applied stress at temperature = temp
matSel = 'resin';
expLength = 24; % experiment length in hours
deg = NaN;

%% Define rectangular test specimens
oal = 165; %mm
width = 12.7; %mm
thickness = 8; %mm

%-------------------------------------------------------------------------------
% User input not necessary below this line. Ideally.
%-------------------------------------------------------------------------------
%% Preallocate space
t = expLength * 3600; % Convert experiment length from hours to seconds
s = zeros(t,3); % Compliance matrix at all times, the columns are [S11, S22, S33]
sInt = zeros(t,1); % Internal stress at all time during the experiment
sEff = zeros(t,1); % Effective stress at all times during the experiment
eRate = zeros(t,1); % Creep rate at all times during the experiment
eInst = zeros(t,1); % Instantaneous strain at time try
eCumu = zeros(t,1); % Cumulative creep at time t

% Check fiber angle is implemented in code
if deg ~= 90 && deg ~= 0 && ~isnan(deg)
  error('This fiber angle as not implemented. Acceptable deg are NaN, 90, 0');
end

%% Get material properties
[resin, zero, ~, ninty, ~, shear] = generateMaterialPropertyTables;

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

%% Initial loading conditions
% Strain in the loading direction
eInst(1) = sApp/mat.inst(pos);
[sInt(1), sEff(1)] = currentLoad(mat, pos, sApp, eInst(1));
eCumu(1) = eInst(1);

%% Find the initial creep rate
[nu, b, eRate] = instStrainRate(mat, pos, sEff(1), 1, temp);
% eRate(1) = 0;
% Initial compliance at time t = 0
s(1,:) = findCompliance(mat, eInst(1), sEff(1), []);

for k = 2:t
  %Calculate stress, strain, and compliance for each time step
  eInst(k) = eCumu(k-1) + eRate(k-1);
  eCumu(k) = eInst(k);
  [sInt(k), sEff(k)] = currentLoad(mat, pos, sApp, eInst(k));
  [nu, b, eRate(k)] = instStrainRate(mat, pos, sEff(k), sEff(1), temp);
  s(k,:) = findCompliance(mat, eInst(k), sEff(k), []);

end
