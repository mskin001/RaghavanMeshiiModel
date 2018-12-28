function [nu, b, eRate] = instStrainRate(mat, pos, sEff, sEffIni, temp)
k = 1.38064852e-23; %boltzmann's constant

% Find activation volume
nu = mat.temp(pos) * mat.cl * sEff^(-mat.d); % initial activation volume
% calculate initial B and beta values based on temperature and applied stress
b = mat.BRatio(pos,2) / (mat.beta(pos,2) * temp);
% calculate initial strain rate
eRate = b * sEff * (-log(sEff/sEffIni)^(1-(1/mat.beta(pos,2))))*...
            exp(-(mat.ae/(k*temp))) * sinh((nu*sEff)/(k*temp));
end
