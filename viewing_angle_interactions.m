function [v_jx, v_jy] = viewing_angle_interactions(v_jx, v_jy, xpos, ypos, vv, j, P)
% The function viewing_angle_interactions will determine which
% interactions are important for each particle j. Only those particle
% which are in the sight cone of particle j will remain. All others
% will be set to zero. We use v_jx and v_jy as these are the current
% interactions. We will determine which of these interactions we can
% keep and which we kan remove. This will be done using the inproduct rule.
% We will asses which of the particles holds a vector with particle j that
% makes an angle of less than 45 degrees with v_0. Only those particles
% that show such a vector with j will be allowed to interact. All others
% will be set to zero. 

% !!! We need to be carefull here. A particle moving from left to right
% will have a v_0 of 1. A particle moving from right to left will have a
% v_0 of -1. We must split the determination into 2 parts. If j is smaller
% or equal to P then the particle moves from left to right. If j is larger
% than P then the particle moves from right to left. 

for i = 1:2*P
    % We will iterate through the list of particles, deciding whether or
    % not it's interaction will be having an effect. 
    

    % This will be so for particles moving from left to right
    a = (((xpos(i)-xpos(j))*vv(j))+((ypos(i)-ypos(j))*vv(2*P+j)))/(sqrt(((xpos(i)-xpos(j))^2)+((ypos(i)-ypos(j))^2)) * sqrt((vv(j)^2)+(vv(2*P+j)^2)));
    % This line of code is part of the inproduct rule. It is the
    % inproduct of the vector between point j and another point and the
    % initial velocity vector. This then divided by the absolutes of
    % these 2 vectors summed. This is then equal to cos(b) with b the
    % angle between the 2 vectors. 

    if a < cosd(45)
        v_jx(i) = ((0.5*1.1)+(0.5*0.9*a))*v_jx(i);
        v_jy(i) = ((0.5*1.1)+(0.5*0.9*a))*v_jy(i);
    end
end


end



