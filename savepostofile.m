function savepostofile(xx, filename)

f = fopen(filename,'w');
for i = xx'
    for j = i
        fprintf(f,'%d;',i);
    end
    fprintf(f,'\n');
end


end

