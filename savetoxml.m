function savetoxml(pos, P, filename, N)

%% Initialization
docNode = com.mathworks.xml.XMLUtils.createDocument('Simulation_Data');
docRootNode = docNode.getDocumentElement;

%% Create General Data Nodes
generalData = docNode.createElement('General_Data');
docRootNode.appendChild(generalData);
nop = docNode.createElement('NOP');
noi = docNode.createElement('NOI');
nop.setAttribute('Number_of_Pedestrians', num2str(2*P));
noi.setAttribute('Number_of_Iterations', num2str(N));
generalData.appendChild(nop);
generalData.appendChild(noi); 



% docRootNode.appendChild(numofpeds);
% 
% peddata = docNode.createElement('Pedestrian_Data'); 


%% Create Pedestrian Nodes
for i = 1:2*P
    thisPedestrian = docNode.createElement('Pedestrian'); 
    % thisPedestrian.setAttribute('id',num2str(i));
    [xx, yy] = split_position_data(pos, i, 2*P);
    arrayfun(@(x,y)add_pedestrian_data_to_pedestrian_node(x,y,i,thisPedestrian), xx, yy);
    docRootNode.appendChild(thisPedestrian); 
end

%% Adding Position Data to Corresponding Pedestrian

    function [xpositions, ypositions] = split_position_data(pos, id, P)
        xpositions = pos(id, :);
        ypositions = pos(id+P, : );
    end

    function add_pedestrian_data_to_pedestrian_node(x,y,i,tp)
        thisElement = docNode.createElement('Pedestrian_Position');
        thisElement.setAttribute('id', num2str(i));
        thisElement.setAttribute('X', num2str(x));
        thisElement.setAttribute('Y', num2str(y));
        tp.appendChild(thisElement);
    end

xmlwrite(filename, docNode);
type(filename);

end