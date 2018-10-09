function limits = lim(popQ , npop , tcromossomo , xmax , xmin);
    %
    %
    
    %%
    for i = 1 : npop
        
        % verifica primeira casa decimal
        if popQ(i , 1) > xmax
            
            popQ(i , 1) = xmax;
            
        elseif popQ(i , 1) < xmin
            
            popQ(i , 1) = xmin;
            
        end %if
        
        % verifica as demais casas decimais
        
        for j = 2 : tcromossomo
            
            if popQ(i , j) > 9
                
                popQ(i , j) = 9;
                
            elseif popQ(i , j) < 0
                
                popQ(i , j) = 0;
                
            end %if
        end %j
    end %i
    
    limits = popQ;
    return;    
end