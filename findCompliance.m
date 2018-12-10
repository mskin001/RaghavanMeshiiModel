function [s] = findCompliance(mat, strain, stress, deg)
% This function finds the compliance matrix for the material under the current
% conditions. stress is the current applied stress, strain is the current strain
% deg is the fiber angle (if deg is empty then the material is only resin).
% This function solves the problem [strain]*[stress]^T. strain_11/stress_11 = S_11
% this relationship is true for all other terms in the compliance matrix. This
% functions assumes the material is orthotropic and that only inplane stress is
% applies with no out of plane deformation so S3_ and S_3 are zero.
% It only solves for S11, S12, S21, S22, S66. More information on this can be
% found in Zhao et al. "Standardized compliance matrixes for general anisotropic
% materials and a simple measure of anisotropy degree based on shear-extension
% coupling coefficent"
%
% Steps for finding the compliance: 1) find the strain in each direction 2) find
% the stress in each direction 3) divide strain matrix by stress matrix.


if isempty(deg)
  % something
  e(1,1) = strain;
  
else
  %something else

end

end
