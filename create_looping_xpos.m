function xposloop = create_looping_xpos(xmax,xpos, j, P)

% It should be noted that the chamber in which particles find
% themselves is never ending. This means that particle j should be able
% to see particles behind him, actually ahead of him. This will be
% recitied here. The chamber ranges from 0 to 120. The total length
% then is 120x. Should a particle find itself more than 60x behind
% particle j, then it should be projected in front of particle j. This
% can be done simply by adapting the xpos of the particles. The y pos
% may remain the same. 
    
%% Initialization

xposloop = xpos;
% First we make a seperate array xposloop to save the new xpos, this is
% so we still have the old xpos to use in other parts of the program.
% We only move particles forward in theory, these will not be shown on
% screen. 

%% Creating new xpos *xposloop*

if xpos(j)<.5*xmax
    % This is only executed if a particle is in the left half of the
    % corridor
    for i = 1:2*P
        if xpos(i) - xpos(j) > .5*xmax
            xposloop(i) = xpos(i) - xmax;
            % If a particle is more than a half corridor length right of
            % particle j, it is projected at the left of particle j
        end
    end
end

if xpos(j)>.5*xmax
    % This is only executed if a particle is in the right half of the
    % corridor
    for i = 1:2*P
        if xpos(j) - xpos(i) > .5*xmax
            xposloop(i) = xpos(i) + xmax;
            % If a particle is more than a half corridor length left of
            % particle j, it is projected at the right of particle j
        end
    end
end

end
    
    
