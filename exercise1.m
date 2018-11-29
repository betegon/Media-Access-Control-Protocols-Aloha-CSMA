%% EXERCISE 1 

% 0 TO M Users in Backlog
% Group 2 parameters
% M=24, 	Number of states.
% sigma=0.3,	Probability of transmit in thinking state. 
% fi=0.2,0.1    Probability of transmit in Backlog state.

clear all
close all
M = 24; %

sig = 0.3; %Prob Transmitir en Thinking; sigma
fi = 0.1; %Prob Transmitir en Back; phi 

pij = zeros(M+2,M+1); %Inicializar Matriz Prob Transisicion. formada por: filas - sistema de M+2 ecuaciones,  columnas - M+1 estados.
pij(M+2,:)=1;


%probk =  Matrix donde Probk(i,j) = prob de ir del estado i al j.
for (i=0:M)% ciclo filas  
    for (j=0:M) %ciclo columnas
        if (j<i-1)
            pij(j+1,i+1)=0; %Arrays en matlab indexados desde 1,2,... probk(1,1)=primer elemento. por eso j+1,i+1   
            	
        elseif (j==i-1)
            pij(j+1,i+1)=(i*fi)*((1-fi)^(i-1))*((1-sig)^(M-i)); %i*fi o fi.
            pij(j+1,i+1)=pij(j+1,i+1)*(-1);
        elseif (j==i)
            pij(j+1,i+1)=((1-(i*fi)*((1-fi)^(i-1)))*((1-sig)^(M-i)))+(((M-i)*sig*(1-sig)^(M-i-1))*((1-fi)^i));
            pij(j+1,i+1)=(1-pij(j+1,i+1));
        elseif (j==i+1)
            pij(j+1,i+1)=(((M-i)*sig*(1-sig)^(M-i-1)))*(1-(1-fi)^i);
            pij(j+1,i+1)=pij(j+1,i+1)*(-1);
        elseif (j>i+1)
            pij(j+1,i+1)=(nchoosek(M-i,j-i))*(sig^(j-i))*(1-sig)^(M-j);
            pij(j+1,i+1)=pij(j+1,i+1)*(-1);
        end
    end
end

prob_states=zeros(M+2,1); %Inicializo las probabilidades de cada Estado
prob_states(M+2,1)=1;% Suma Prob Igual a 1
x=linsolve(pij,prob_states); % x = Probabilidades de cada Estado

Pe=zeros(M+1,1); %Probabilidad de Exito en cada Estado
for i=0:M
    Pe(i+1)=(1-fi)^(i)*(M-i)*sig*(1-sig)^(M-i-1)+i*fi*(1-fi)^(i-1)*(1-sig)^(M-i);
end

S=(sum(Pe.*x)); %Throughtput
D=1-(1/sig)+(M/S); %Retardo

%%%%%%%%%GRAFICA PARTE 1%%%%%%%%

 
  
 
 %%%%%%%%%GRAFICA
 
figure(1)
t=0:M;
stm = stem(t,x)
title('Probabilidad de cada estado (fi = 0.2)');
grid on
set(gca, 'YScale', 'log')
sum_probs = sum(x)

