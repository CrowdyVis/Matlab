function [pos, vv] = compiling_vv(pos, P, xmax, ymax, ymin, n, v_0, vv)
% compiling_vv is a funcgtion that will return the new velocities, vv, to
% the main program. It determines each of the seperate interactions and
% then summates these. 
% Input Parameters:
% pos = matrix with positions.
% P = The number of points available.
% ymax = The upper boundary.
% ymin = The lower boundary.
% n = The iteration in which we find ourselves.
% v_0 = The initial velocities.
% vv = The current velocity which will be updated here. 

%% Compile vv

for j = 1:2*P
    % A new velocity will be determined for each point. This means
    % iterating through the points. Each step will be performed for each
    % point.
    
    %% Ensure Boundaries are Kept
    
    if pos(2*P+j,n-1) >= ymax || pos(2*P+j, n-1) <= ymin
        pos(2*P+j,n-1)= pos(2*P+j,n-2);
    end
    % This step ensures that all parts remain in the boundaries. No
    % exceptions as you will sometimes see occuring. If the y value of any
    % particle leaves the bounded area, it will be returned within the
    % boundaries at the same height as before it left.

    %% Select x and y positions
    
    xpos = pos(1:2*P, n-1);
    ypos = pos(2*P+1:4*P, n-1); 
    % To simplify life we here obtain the x and y positions of each
    % particle and keep those seperate. They will be used to determine vv
    % in later steps, the actual determination of the next x and y
    % positions will take place in the MainProgram. 
    
    %% Look into the distance
    
    % It should be noted that the chamber in which particles find
    % themselves is never ending. This means that particle j should be able
    % to see particles behind him, actually ahead of him. This will be
    % recitied here. The chamber ranges from 0 to 120. The total length
    % then is 120x. Should a particle find itself more than 60x behind
    % particle j, then it should be projected in front of particle j. This
    % can be done simply by adapting the xpos of the particles. The y pos
    % may remain the same. 
    xposloop = create_looping_xpos(xmax,xpos, j, P);

    %% Determine the Basic Interactions

    [v_jx, v_jy] = basic_interactions(xposloop, ypos, j, P);
    % In basic_interactions we use the position of each particle to find
    % out what the interaction is between one particle and every other.
    % Determined using the distance between two particles.

    %% Implementing a field of view
    
    [v_jx, v_jy]  = viewing_angle_interactions(v_jx, v_jy, xposloop, ypos, vv, j, P);
    % The function viewing_angle_interactions will determine which
    % interactions are important for each particle j. Only those particle
    % which are in the sight cone of particle j will remain. All others
    % will be set to zero. We use v_jx and v_jy as these are the current
    % interactions. We will determine which of these interactions we can
    % keep and which we kan remove. 
    
    %% Morse Potential
    
    m_j = morse_potential_interactions(xposloop, ypos, j, n, P);
    % The Morse potential is a degree of affinity between two particles. This
    % stems from the knowledge that particles not repel each other but also
    % have an affinity for each other. This effect will be compiled within the
    % function morse_potential_interactions, returning a list of attractive
    % forces per particle j.
    
    m_jx = m_j(1:2*P);
    m_jy = m_j(2*P+1:4*P);
    % Simply splitting the morse potential vector into two parts to
    % simplify the code later on when summing the interactive forces. 
    
    %% Final summation
    
    vv  = summing_of_forces(v_0, vv, v_jx, v_jy, m_jx, m_jy, j, P, ypos, ymax, ymin);
    % In summing_of_forces we take all interaction forces determined above
    % and total them to give the total interactive force acting upon one
    % particle. 

    %% Looping
    
    pos(pos(:,n)>xmax,n) = pos(pos(:,n)>xmax,n) - xmax;
    pos(pos(:,n)<0,n) = pos(pos(:,n)<0,n) + xmax;
    
    % To loop the particles we will return the particles to an x position
    % exactly 120 x positions backwards, relative to the direction they
    % were going when they reach the end of the channel

end
