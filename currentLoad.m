function [sInt, sEff] = currentLoad(mat, pos, stress, strain)

% sInt = internal stress.
sInt = strain .* mat.rubber(pos);
% sEffIni = effective initial stress. currently this is under the initial loading
% conditions
sEff = stress - sInt;

end
