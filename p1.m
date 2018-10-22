clear all
close all
M = 24; %Numero de estados

sig = 0.3; %Prob Transmitir en Thinking; sigma
fi = 0.1; %Prob Transmitir en Back; phi

pij = zeros(M+2,M+1); %Inicializar Matriz Prob Transisicion
pij(M+2,:)=1;


for (i=0:M)
    for (j=0:M)
        if (j<i-1)
            pij(j+1,i+1)=0;
            
        elseif (j==i-1)
            pij(j+1,i+1)=(i*fi)*((1-fi)^(i-1))*((1-sig)^(M-i));
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

% comprobacion_probs=zeros(M+1,1);
% for i=1:M+1 % la ultima fila no hay que sumarla, son los 1s.
%     comprobacion_probs(i)=sum(pij(i,:));
% end
% comprobacion_probs

r=zeros(M+2,1);
r(M+2,1)=1;% sumatorio de probabilidades es 1
x=linsolve(pij,r) % x es el vector de probabilidades de estado


Pe=zeros(M+1,1);
for i=0:M
    Pe(i+1)=(((1-fi)^i)*(M-i)*sig*((1-sig)^(M-i-1)))+(i*fi*((1-fi)^(i-1))*((1-sig)^(M-i)));

end
 Pe
 

 S=0;
 for i=0:M
     g=Pe(i+1)*x(i+1);
     S=S+g;
 end
 S

 %Con 0.2 de fi hay ef captura pero con 0.1 no
 
 D=1-(1/sig)+(M/S)
 
 
 
 
 
 
 
 
 
 
 
 %%%%%%%%%GRAFICAS
 
 figure(1)
 stem(x) %%PRob de cada uno de los estados
 
fi=0.3
for sig=0:10^0.001:1
    Pe=zeros(M+1,1);
    for i=0:M
        Pe(i+1)=(((1-fi)^i)*(M-i)*sig*((1-sig)^(M-i-1)))+(i*fi*((1-fi)^(i-1))*((1-sig)^(M-i)));
    end
     S=0;
 for i=0:M
     g=Pe(i+1)*x(i+1);
     S=S+g;
 end
 Ss[
     D=1-(1/sig)+(M/S)
 