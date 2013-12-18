function vv = summing_of_forces(v_0, vv, v_jx, v_jy, m_jx, m_jy, j, P, ypos, ymax, ymin)
% The function summing_of_forces will sum all forces relavant to each
% particle and store these in the list vv where the new velocities are
% stored. The velocities are therefore determined by the interactions
% between particles.


vv(j) = v_0(j) + sum(([v_jx.*2; m_jx]));
% Here All forces determinging the x direction of the velocity are being
% summed. These are simply v_jx. 

vv(2*P+j) = v_0(2*P+j) + sum([(v_jy.*2); 
    6*((ypos(j)-ymax)/((ypos(j)-ymax)^2));
    6*((ypos(j)-ymin)/((ypos(j)-ymin)^2)); 
    m_jy]);
% In thins step we sum all interactions affecting the y direction of the
% velocity. This includes the boundaries. When taking only the shortest
% distance between a particle and the horizontal bounday into account this
% will be an interaction directed only in the y direction. 



end