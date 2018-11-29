[resin, zero, ten, ninty, fourtyfive, shear] = generateMaterialPropertyTables;

stress = linspace(10^4, 10^8, 10000);

%% Evaulate resin data

nu = zeros(length(stress), length(resin.temp));

cR = mean([resin.cu resin.cl]);
cZ = mean([zero.cu, zero.cl]);
cT = mean([ten.cu, ten.cl]);
cN = mean([ninty.cu, ninty.cl]);

for k = 1:length(resin.temp)
  nuR(k) = resin.temp(k) .* cR .* stress .* resin.d;
  nuZ(k) = zero.temp(k) .* cZ .* stress .* zero.d;
  nuT(k) = ten.temp(k) .* cT .* stress .* ten.d;
  nuN(k) = ninty.temp(k) .* cN .* stress .* ninty.d;

end
[rows,cols] = size(nuR);

for k = 1:cols
  plot(nu(:,k),stress)
end
