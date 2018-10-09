function winner = tnt(npop)
    % 
    % Torneio de tres
    
    x = round((npop - 1) * rand(1 , 3)) + 1; % escolhe dois pais        
    x = sort(x);
    
    winner = x(1);
    
end