function [ phi_p, phi_t ] = modal_continuous_persistent( V, lambda, i, dt, thresh)
% Calculate persistent and transient modal controllability of node i. 
% Intuitively, nodes with high persistent controllability will result in
% large perturbations to slow modes of the system when stimulated, and
% nodes with high transient controllability will result in large
% perturbations to fast modes of the system when stimulated
% Inputs:  
% V         The NxN matrix conatining eigenvectors of your system, where N
%           is the number of nodes
% lambda    The Nx1 vector of eigenvalues for your system
% i         This index of the node you wish to calculate the
%           controllability of
% dt        The time step of the system
% thresh    The thresh hold for calculating persistent and transient modal
%           controllability. For example, if thresh is .1, this will
%           use the 10% slowest modes for persistent controllability, and
%           the 10% fastest modes for transient controllability.

% Outputs:
% phi_p     Persistent controllability of the node (should be between 0 and
%           1)
% phi_t     Transient controllability (should be between 0 and 1)

% @author JStiso


% convert to discrete lambda - comment out if system if already discrete
discrete_lambda = exp(lambda.*dt);
% get only the X% largest values
[modes, idx] = sort(discrete_lambda);
cutoff = round(numel(modes)*thresh);
transient_modes = modes(1:cutoff);
persistent_modes = modes((end-cutoff+1):end);
% get controllability
phi_p = sum((1 - (persistent_modes).^2).*(V(i,idx((numel(idx)-cutoff+1):end)).^2)');
phi_t = sum((1 - (transient_modes).^2).*(V(i,idx(1:cutoff)).^2)');

end
