function crow = crowd(mdamp , npop)
    %
    % Algoritmo para distancia de multidao (crowdist)
    % a funcao clasifica a distancia entre as solucoes
    %
    % Sintaxe :
    % crowd(mdamp , npop) = crow , onde:
    % mdamp representa a matriz de fitness e npop o tamanho da populacao


    %% inicia distância de multidão

    crow = zeros(1 , npop);
    mdamp(npop+1,:) = 500;
    
%     stp = mdamp(npop , 3); % verifica quantas fronteiras existem
%     
%     stp1 = 0;  % logica de saida do da fronteira k
%     x = zeros(1 , k); % define tamanho do contador de solucoes por fronteira
%     k = 1;    % contador de fronteiras
%     
%     while k <= stp
%         while stp1 == 0
%             if mdamp(i , 3) == mdamp(i + 1 , 3)
% 
%                 x(k) = x(k) + 1;
% 
%             else
% 
%                 stp1 = 1;
%                 k = k + 1;
% 
%             end %if        
%         end %while stp1
%     
%         for i = 1 : 2
% 
%             [z y] = sort(mdamp(: , i) , 'descend');
%             crow(y(1)) = 100;
%             crow(x) = 100;
% 
%             for j = 2 : x
%                 crow(y(j)) = crow(y(j)) + (z(j - 1) - z(j + 1)) / (z(1) - z(x));
%             end %j
% 
%         end %i
%     end %while stp

    k = 0; % define inicio da fronteira

    for i = 1 : (npop)
        if mdamp(i , 3) ~= mdamp(i + 1 , 3)
            if (i - k) > 2

                for z = 1 : 2

                    if k == 0

                        [x y] = sort(mdamp(k + 1 : i , z), 'descend');
                        crow(y(1)) = crow(y(1)) + 100;
                        crow(y(i - k)) = crow(y(i - k)) + 100;

                        for j = 2 : i - k - 1

                            crow(y(j)) = crow(y(j)) + (x(j - 1) - x(j + 1)) / (x(1) - x(i - k - 1));

                        end %j

                    else

                    [x y] = sort(mdamp(k + 1 : i , z), 'descend');
                    crow(y(1) + k) = crow(y(1) + k) + 100;
                    crow(y(i - k) + k) = crow(y(i - k) + k) + 100;

                        for j = 2 : i - k - 1

                            crow(y(j) + k) = crow(y(j) + k) + (x(j - 1) - x(j + 1)) / (x(1) - x(i - k - 1));

                        end %j

                    end
                end %z

            elseif (i - k) == 2

                [x y] = sort(mdamp(k + 1 : i , z), 'descend');
                crow(k + 1) = crow(k + 1) + 100;
                crow(i) = crow(i) +100;

            elseif (i - k) == 1
                crow(k + 1) = crow(k + 1) + 100;

            end %if

            k = i;

        end %if
    end %i
    
    
%     for i = 1 : npop
%         crow(i)= 0;
%     end %i
% 
%     for i = 1 : 2
% 
%             [x y] = sort(mdamp(: , i) , 'descend');
%             crow(y(1)) = 100;
%             crow(y(npop)) = 100;
% 
%             for j = 2 : npop-1
%                 
%                 crow(y(j)) = crow(y(j)) + (x(j-1) - x(j+1)) / ...
%                     (x(1) - x(npop));
%                 
%             end %j
% %             disp(crow)
%     end %i

end
