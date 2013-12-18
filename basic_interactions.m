function [v_jx, v_jy] = basic_interactions(xpos, ypos, j, P)
% The output of thins function will be v_j, a list of the interaction
% between particle j and each other particle and r_sq, a list of the
% absolute interactive force between particles j and each other. 

%% Initialization
v_jx = zeros(2*P,1);
v_jy = zeros(2*P,1);
% For each point j and each iteration n a new velocity will be made, in
% which the interactive force between j and each other point will be
% stored. 

%% Computing v_j

v_jx = xpos(j) - xpos;
v_jy = ypos(j) - ypos;

% The velocities in the x and y direction are first viewed as simply the
% distance between point j and each other point in both the x and the y
% directions. This will be adapted by dividing by the absolute sum of these
% distances. 

%% Computing r_sq
% r_sq is the square of the interactions in the x direction summed with the
% square of the interactions in the y direction. No differentation should
% be made between left and right moving particles as the summing will
% remove all negatives. 

r_sq = (v_jx.^2 + v_jy.^2);
r_sq(j) = 1;
r_sq = r_sq + (r_sq == 0);

%% Creating Final v_jx and v_jy

v_jx = (v_jx./r_sq); 
v_jy = (v_jy./r_sq);


end