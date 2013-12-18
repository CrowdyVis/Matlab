%% Initialisation
% Here we will define all the variables to be used later on in the program.

P = 40; % P is the number of points moving in any one direction.
deltat = 1; % This refers to the step time.
N = 1000; % This will become the number of iterations we perform.

xmax = 120; % This will be the "end" of the corridor.
ymax = 40; % This will be the upper boundary.
ymin = 0; % This will constitute the lower boundary.

x_0 = [.2*xmax * rand(P,1);xmax*(.8 + .2*rand(P,1))]; 
% These are the x positions. The first set will move from left to right,
% the second set from right to left.

y_0 = ymax*(.2 + .6*rand(2*P,1));
% These are the y positions. Only one set has been made, but with size 2*P,
% the first P elements are the y positions for the points moving from left
% to right and the second set of P elements are the y positions for the
% points moving from right to left. 

pos = zeros(4*P, N);
% In this matrix we will store the positions of the points after each
% iteration. The first 2*P of each column will become the x positions the
% second 2*P will become the y positions, left to right and right to left
% as previously determined.

pos(1:2*P,1) = x_0;
pos(2*P+1:4*P, 1) = y_0; 
% The first column of the positions matrix will hold the initial positions
% x_0 and y_0.

v_0 = [ones([P,1]);(ones([P,1]).*(-1));zeros(2*P,1)];
% These are the initial velocities of the particles. Particles moving from
% left to right have a positive velocity of 1. Particles moving from right
% to left have a negative velocity of -1. The particles have no velocity in 
% the y direction. They are told to only move in a horizontal direction to 
% the opposite side of the channel. 

vv = zeros(4*P, N);
vv(:, 1) = v_0;
% For the first iteration the velocities will be equal to the initial
% velocities as expected. The velocities will be stored in a matrix much
% like the positions of the particles.

%% Using differential equation to find the new positions of the particles.

for n = 2:N % Iterating from 2 through to N will find the position at each iteration
    pos(:,n) = pos(:, n-1) + deltat*vv(:, n-1);
    % This will determine the new positions and add them to the matrix in
    % which the positions are stored. New position is equal to the previous
    % position plus the new velocity multiplied by the time step.
    
    vvold = vv(:, n-1);
    [pos, vvnew] = compiling_vv(pos, P, xmax, ymax, ymin, n, v_0, vvold);
    vv(:, n) = vvnew;
    % Within compiling_vv we will compile the new vv (velocity Vector). 
    % We will find the new velocity of each point, and return this in the 
    % list vvnew. The velocity vecot vvnew will then be added to the 
    % velocity vector matrix allowing previous velocities to be called upon
    % when determining the viewing angle. Note that the old velocity vector
    % is given to the compiling_vv function for use. 
    
end

%% Smoothing the paths
while j < 3
    for i = 1:4*P
        pos(i,:) = smooth(pos(i,:), 5); %Smooth each path
    end
    j = j+1;
end

% %% Save as Text File
% savepostofile(pos, 'xx.txt')
% savepostofile(vv, 'vv.txt')
% savepostofile(pos(1,:), 'xxx.txt')
% savepostofile(pos(2*P+1, :),'xxz.txt')

%% Save as XML File
savetoxml(pos, P, 'pedestrian_datasmooth1.xml', N)

%% Plotting the results
for i = 1:N
    plot([0 xmax], [ymax ymax], '-'); 
    hold on
    plot([0 xmax], [ymin ymin], '-');
    scatter(pos(1:P, i), pos(2*P+1:3*P, i), 'r');
    scatter(pos(P+1:2*P,i), pos(3*P+1:end,i), 'b');
    hold off
    xlim([0,xmax]);
    ylim([-.2*ymax,1.2*ymax])
    pause(0.000001)
end