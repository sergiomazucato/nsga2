function cross = cross00(cross , tcromossomo)
    % 
    % Cruzamento pontual.
    % Um vetor binario aleatorio de tamanho igual ao numero de genes
    % do cromossomo e definido. Para cada entrada alta do vetor   os
    % genes dos pais sao cruzados.
    
    y = round(rand(1 , tcromossomo));
    
    while sum(y) == 0    
        y = round(rand(1 , tcromossomo));
    end %while
    
    for j = 1 : tcromossomo

        if y(j) ~= 0
            
            x = cross(1 , j);
            
            cross(1 , j) = cross(2 , j);
            cross(2 , j) = x;

        end %if
    end %j
    
    return;
end