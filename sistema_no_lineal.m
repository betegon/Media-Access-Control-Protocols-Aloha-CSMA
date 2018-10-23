function F = sistema_no_lineal(x)
  %%%%
  % FUNCION QUE UTILIZAREMOS PARA fsolve
  % x(1) = p = probabilidad de colision
  % x(2) = tau = probabilidad de transmision en una ranura cualquiera
  % parameters 
  m = 3;  % t en los apuntes
  w = 32;
  N = 10;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  F(1)= x(1)-1+(1-x(2))^(N-1); % probabilidad de colision
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Sumatorio de i=0 a i=m-1 de (2*p)^1
  sumat=0;
  for i=0:(m-1)
    sumat=sumat+((2*x(1))^i);
  end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  F(2)=(x(2)-(2/(1+w+(x(1)*w*(sumat)))));
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%