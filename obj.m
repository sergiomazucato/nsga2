function y = obj(x)
    %
    % Funcao que calcula resultados das seguintes funcoes objetivo
    % Primeira funcao objetivo: y = x ^ 2
    % Segunda funcao objetivo: y = (x - 1) ^ 2
    %
    % sintaxe: obj(x) = y, onde:
    % x representa um valor real e
    % y um vetor coluna de duas linhas com o calculo das funcoes para o
    % valor de x.
    %
    % Exemplo:
    %
    % >> x = 2;
    % >> y = obj(x)
    % >>
    % >> y = 
    % >>
    % >>       4
    % >>       1
    
    
    y = [0 ; 0];
    
    y(1) = 4 - (x - 2) ^ 2; %x ^ 2;
    y(2) = x ^ 2;
    
    return
end