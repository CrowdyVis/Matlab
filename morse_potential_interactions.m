function m_j = morse_potential_interactions(xpos, ypos, j , n , P)
% The Morse potential is a degree of affinity between two particles. This
% stems from the knowledge that particles not repel each other but also
% have an affinity for each other. This effect will be compiled within the
% function morse_potential_interactions, returning a list of attractive
% forces per particle j.

%% Initialisation

% A number of constants must be defined within the Mathematical formula for
% the Morse Potential, done here:

ca = 1;
la = 100;
cr = 1;
lr = 200;

m_j = zeros(4*P,1);
% An empty array is created to aid with retaining the interactive forces.

%% Compiling the Morse Potential

m_j(1:2*P) = -(xpos(j) - xpos);
m_j(2*P+1:4*P) = -(ypos(j) - ypos);
m_j = m_j + (m_j == 0);
% In these steps we compile the distance between the point j and each other
% point, in both x and y direction. 

for i  = 1:4*P
    m_j(i) = (((ca/la)*exp((-abs(m_j(i)))/la))-((cr/lr)*exp((-abs(m_j(i)))/lr)))*((m_j(i))/(abs(m_j(i))));
end
% This then is the formula for the Morse Potential. m_j(i) is iterated so
% that each distance is plugged into the formula, creating a new value
% which we will take as the morse potential between particle j and each
% other particle.


end
