%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                  %%%
%%%                    NSGA-II                       %%%
%%%                                                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% procura a fronteira de pareto para as funcoes definidas na function obj
% a fronteira contem os maiores valores da primeira funcao e os menores
% da segunda funcao

clear all;
clc;
close all;

xmax = 3;
xmin = -1;

npop = 50;
tcromossomo = 5;

txm = 0.25;

maxit = 5000;
counter = 1;

%% cria populacao inicial

pop = zeros(npop , tcromossomo);

pop(: , 1) = round(xmax * rand(1 , npop) + xmin * rand(1 , npop));
pop(: , 2) = round(9 * rand(1 , npop));
pop(: , 3) = round(9 * rand(1 , npop));
pop(: , 4) = round(9 * rand(1 , npop));
pop(: , 5) = round(9 * rand(1 , npop));

%% verifica fitness inicial

mdamp = zeros(npop , 6);

x = 0; % variavel de armazenamento temporario

for i = 1 : npop
    
    x = pop(i , 1) + pop(i , 2) / 10 + pop(i , 3) / 100 + ...
        pop(i , 4) / 1000 + pop(i , 5) / 10000;
    
    x = obj(x);
    
    mdamp(i , 1) = x(1);
    mdamp(i , 2) = x(2);
    mdamp(i , 6) = i;
    
end %i

%% verifica fronteiras por não dominância para populacao inicial

F = Pareto(mdamp , npop); % verifica fronteiras

%% organiza populacao inicial de acordo com as fronteiras

[popP mdampP] = orgF(pop , mdamp , F);

%% calcula distância de multidão

crow = crowd(mdampP , npop);
mdampP(: , 4) = crow;

%% disposicao da matriz de fitness

% | fit1 | fit2 | fronteira | crowdist | end_atual | end_antigo |

%% organiza fronteiras por crowdist em ordem decrescente

[popP mdampP] = orgCrow(popP , mdampP , npop);

%% Faz cruzamento em popP e envia para popQ

popQ = zeros(size(popP));

%break

while counter < maxit
    
    k= 1;

    for i = 1 : (round(npop / 2) - mod(npop , 2))
        
        %% faz torneio
        
        x = [0 0];
        
        x(1) = tnt(npop);
        x(2) = tnt(npop);
        
        xx = 1;
        while x(1) == x(2)
            
           x(2) = tnt(npop);
           xx = xx + 1;
           
           if xx >= 10
               
               break
               
           end %if
        end %while
        
        %% faz cruzamento
        
        cross = [popP(x(1) , :) ; popP(x(2) , :)];
        
        cross = cross00(cross , tcromossomo);
        
        popQ(k , :) = cross(1 , :);
        popQ(k + 1 , :) = cross(1 , :);

        k = k + 2;

    end %i

    %% mutacao em popP
    for i = 1 : round(npop * txm)
        
        y = round((npop-1) * rand) + 1; % escolhe individuo para mutacao
        x = popP(y , :);
        
        popQ(y , :) = mut(x , tcromossomo);
        
    end %i
    
    %% verifica limites de popQ
    
    popQ = lim(popQ , npop , tcromossomo , xmax , xmin);
    
    %% verifica fitness de popQ

    mdampQ = zeros(size(mdampP));
    
    x = 0; % variavel de armazenamento temporario

    for i = 1 : npop

        x = popQ(i , 1) + popQ(i , 2) / 10 + popQ(i , 3) / 100 + ...
            popQ(i , 4) / 1000 + popQ(i , 5) / 10000;

        x = obj(x);

        mdampQ(i , 1) = x(1);
        mdampQ(i , 2) = x(2);
        mdampQ(i , 6) = i;

    end %i
    
    %% verifica fronteiras por nao dominancia para popQ
    
    F = Pareto(mdampQ , npop); % verifica fronteiras

    %% organiza popQ de acordo com as fronteiras

    [popQ mdampQ] = orgF(popQ , mdampQ , F);
    clear F;
    
    %% calcula distância de multidão em popQ

    crow = crowd(mdampQ , npop);
    mdampQ(: , 4) = crow;
    clear crow;

    %% organiza fronteiras de popQ por crowdist em ordem decrescente

    [popQ mdampQ] = orgCrow(popQ , mdampQ , npop);

    %% define popR

    popR = [popP ; popQ];
    mdampR = [mdampP ; mdampQ];
    
    %% verifica fronteiras por nao dominancia em popR

    F = Pareto(mdampR , 2 *npop); % verifica fronteiras
    
    %% organiza popR de acordo com as fronteiras
    
    [popR mdampR] = orgF(popR , mdampR , F);
    clear F;
    
    %% calcula distancia de multidao em popR
    
    crow = crowd(mdampR , 2 * npop);
    mdampR(: , 4) = crow;
    clear crow;
    
    %% organiza fronteiras de popR por crowdist em ordem decrescente
    [popR mdampR] = orgCrow(popR , mdampR , 2 * npop);
    
    %% salva nova geracao de pais (popP)
    
    popP = popR(1 : npop , :);
    mdampP = mdampR(1 : npop, :);
    
    counter = counter + 1;
    
end %while

%% preparacao das imagens

REF = zeros(1 , npop);
nsga2x = REF;
REF = linspace(xmin + 1 , xmax + 1 , npop);

ref = zeros(npop , 2);
nsga2 = ref;

for i = 1 : npop
        
    % prepara os resultados do nsga2
    nsga2x(i) = popP(i , 1) + popP(i , 2) / 10 + popP(i , 3) / 100 + ...
        popP(i , 4) / 1000 + popP(i , 5) / 10000;

    x = obj(nsga2x(i));

    nsga2(i , 1) = x(1);
    nsga2(i , 2) = x(2);
    
    % prepara os resultados da referencia
    x = obj(REF(i));

    ref(i , 1) = x(1);
    ref(i , 2) = x(2);
        
end %i

%% imagens

figure(1)

plot(REF , ref(: , 1) , '-g', REF , ref(: , 2) , '-.g' , nsga2x , nsga2(: , 1)  , 'k.' , nsga2x , nsga2(: , 2) , 'r.');
grid
title('Valor objetivo das funcoes');
xlabel('Solucao','fontname','times new roman');
ylabel('Objetivos','fontname','times new roman');
legend('Ref Obj1', 'Ref Obj2' , 'NSGA2 Obj1' , 'NSGA2 Obj2' , 'Location' , 'Best')
set(gca,'fontname','times new roman');

%ref = ref (npop / 2 : npop , :);
figure(2)
plot(ref(: , 1) , ref(: , 2) , '-g ', nsga2(: , 1) , nsga2(: , 2) , 'k.')
grid
title('Conjunto de Pareto');
xlabel('Objetivo 1','fontname','times new roman');
ylabel('Objetivo2','fontname','times new roman');
legend('Pareto Referencia', 'Pareto NSGA2' , 'Location' , 'Best')
set(gca,'fontname','times new roman');

