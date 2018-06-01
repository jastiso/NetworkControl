function [ traj_dist, state_corr ] = get_traj( X, xT, nTime)
%takes a high dimensional state space (output from open loop control) and
%gets measure of similarity to the target (distance, and correlation)
%   inputs:
% X         : the state space. should be 4
% xT        : the target state. Should be 2D (here it is post freq state)
% nTime     : number of time points
%
%   outputs:
% traj_dist     : norm of distance from target over time
% state_corr    : correlation with target state over time

%@author JStiso, jeni.stiso@gmail.com Aug 2017

% initialize trajectories and energies
traj_dist = zeros(1, nTime);
state_corr = zeros(1, nTime);

% for every trial, get magnitudes of trajectory distance and energy

% get trajectory distance ||(x(t) - x_T)||
tmp_dist = X - permute(repmat(xT, [nTime, 1, 1]), [2,3,1]);
% do norm for each time
for i = 1:nTime
    traj_dist(i) = norm(tmp_dist(:,:,i), 'fro');
    % get correlation
if ~isrow(squeeze(xT))
    state_corr(i) = corr2(squeeze(X(:,:,i)), squeeze(xT));
else
    state_corr(i) = corr(squeeze(X(:,:,i)), squeeze(xT)');
end
end

