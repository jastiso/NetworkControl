function [ x ] = openLoopControl( A, B, xi, U)
% This function caclulates the trajectory for the network given our model
% if there are no constraints, and the target state is unknown, using the
% control equation precess dx = Ax(t) + BU(t). x(t) is the state vector, A is
% the adjacency matrix, U(t) is the time varying input as specified by the
% user, and B selects the control set (stimulating electrodes)
%
%   Inputs
% A             : NxN state matrix, where N is the number of nodes in your
%               network (for example, a structural connectivity matrix 
%               constructed from DTI). A should be stable to prevent
%               uncontrolled trajectories.
%
% B             : NxN input matrix, where N is the number of nodes. B
%               selects where you want your input energy to be applied to.
%               For example, if B is the Identity matrix, then input energy
%               will be applied to all nodes in the network. If B is a
%               matrix of zeros, but B(1,1) = 1. then energy will only be
%               applied at the first node.
% 
% xi            : NxM initial state of your system where N is the number of
%               nodes, and M is the number of independent states (ie 
%               frequency bands). xi MUST have N rows, however, the number
%               of state measurements can change (and can be equal to 1). 
%
% U             : NxMxT matrix of Energy, where N is the number of nodes, M
%               is the number of state measurements, and T is the number of
%               time points. For example, if you want to simulate the
%               trajectory resulting from stimulation, U could have
%               log(StimFreq)*StimAmp*StimDur as every element. You can
%               also enter U's that vary with time, or are different
%               accross frequency bands.
%
%   Outputs
% x             : x is the NxMxT trajectory that results from simulating
%               x(t+1) = Ax(t) + Bu(t) the equation with the parameters
%               above.
%
% @author JStiso 
% June 2017

% Simulate trajectory
T = size(U,3);
N = size(A,1);
M = size(xi,2);
% initialize x
x = zeros(N, M, T);
xt = xi;
for t = 1:T
    x(:,:,t) = xt;
    dx = A*xt + B*squeeze(U(:,:,t)); % state equation
    xt = xt + dx;
end
end

