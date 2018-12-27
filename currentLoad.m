function [eIni, sInt, sEff] = currentLoad(mat, pos, stress)

% eIni = initial strain in the loading direction (e_11)
eIni = stress/mat.inst(pos);
% sInt = internal stress. currently this value is under the initial
% loading conditions
sInt = eIni .* mat.rubber(pos);
% sEffIni = effective initial stress. currently this is under the initial loading
% conditions
sEff = stress - sInt;

end
