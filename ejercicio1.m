%% EJERCICIO 1 

% PRIMERA PARTE - 0 A M USUARIOS EN BACKLOG
% PARAMETROS GRUPO 2
%   M=24, sigma=0.3, fi=0.2,0.1
M = 24;
sigma = 0.3;
fi = 0.2; %%es un rango 0.1-0.2 o son dos valores?
probk = ones (M+2,M+1); %sistema de M+2 ecuaciones, M+1 estados. Vers si inicializar con ceros es posible.
%probk =  Matrix donde Probk(i,j) = prob de ir del estado i al j.
  for i=0;M % ciclo filas   %%% IDEA, DE 1 A M+1 ASI QUITAMOS TODOS LOS J+1,I+1
    for j=0:M %ciclo columnas
      if(j<i-1)
        probk(j+1,i+1) = 0; %Arrays en matlab indexados desde 1,2,... probk(1,1)=primer elemento. por eso j+1,i+1   
      elseif(j==i-1)
        probk(j+1,i+1) = i*fi((1-fi)^(i-1))*((1-sigma)^(M-i)) 
      elseif(j=i)
        probk(j+1,i+1) = 
      elseif(j=i+1)
        probk(j+1,i+1) = 
      elseif(j<i+1)
        probk(j+1,i+1) = 
      end
      
   end
end   
