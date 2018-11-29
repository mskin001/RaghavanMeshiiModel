[resin, zero, ten, ninty, fourtyfive, shear] = generateMaterialPropertyTables;

stress = linspace(10^4, 10^8, 10000);

%% Evaulate equation 14 with C and D data from table 7

nu = zeros(length(stress), 3);
nuR = nu;
nuT = nu;
nuN = nu;

cRmean = mean([resin.cu resin.cl]);
cTmean = mean([ten.cu, ten.cl]);
cNmean = mean([ninty.cu, ninty.cl]);

cR = [resin.cl, cRmean, resin.cu];
cT = [ten.cl, cTmean, ten.cu];
cN = [ninty.cl, cNmean, ninty.cu];

for k = 1:3
  nuR(:,k) = cR(k) .* stress .^ -resin.d;
  nuT(:,k) = cT(k) .* stress .^ -ten.d;
  nuN(:,k) = cN(k) .* stress .^ -ninty.d;

end
[rows,cols] = size(nuR);

% for k = 1:cols
%     figure(1)
%     loglog(stress, nuR(:,k))
%     hold on
%
%
% end

figure(1)
loglog(stress,nuR)
xlabel('Effective Stress: Pa')
ylabel('Activation volume/T : [m^3K^-1]')
legend('Lower Bound', 'Mean C Value', 'Upper Bound')

figure(2)
loglog(stress,nuT)
xlabel('Effective Stress: Pa')
ylabel('Activation volume/T : [m^3K^-1]')
legend('Lower Bound', 'Mean C Value', 'Upper Bound')

figure(3)
loglog(stress,nuN)
xlabel('Effective Stress: Pa')
ylabel('Activation volume/T : [m^3K^-1]')
legend('Lower Bound', 'Mean C Value', 'Upper Bound')
