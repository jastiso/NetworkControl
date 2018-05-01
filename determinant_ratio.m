function [ det_rat ] = determinant_ratio( A, driver, nondriver )
% This function calculates the deteminant ratio of a graph, given indices
% of the driver and non-driver nodes. Note that there must be more driver
% than non-driver nodes. See Kim et al 2017 Nat. Phys for more info.
% It is important to note that this metric showed theoretical validity for
% situations where there were more driver than non driver nodes, the driver
% and non-driver nodes were not overlapping, and where the states were zero
% mean. It is important to note when these assumptions are violated.
%
% Since determinants are computationally difficult to calculate, we
% calculate the average determinant ratio across all non-driver nodes as
% the inverse of trace of A21xA21'. See Kim et. al. Net Phys for more
% details.
%
%   Input
% A             An NxN adjacency/connectivity matrix
% drivers       An Nx1 logical or 0-1 vector, where 1 indicates the position
%               of a driver node
% nondrivers    An Nx1 logical or 0-1 vector, where 1 indicates the
%               position of the non-driver node. nondrivers can be equal to
%               ~drivers, but does not have to be


% Outputs
% det_rat       The detminant ratio of the specified control set up

% @author JStiso

% check that there are more drivers than non-drivers
if sum(nondriver) > sum(driver)
    warning('You should not have more non-driver than driver nodes')
    return
end

% get A21
A21 = A(driver,nondriver)';
Q = A21*A21';
det_rat = trace(inv(Q));

end

