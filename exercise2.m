clear all
close all

fun = @sistema_no_lineal;
x0=[0,0]
sol=fsolve(fun,x0)
p = sol(1)
tau = sol (2)
m = 3;  % t en los apuntes
w = 32;
N = 10;
s=zeros(60,1)
for N=1:60
  pexito = (N*tau*(1-tau)^(N-1))/(1-((1-tau)^N)) % probabilidad de exito
  ptransmision = 1-((1-tau)^N) % probabilidad de transmision

   %%%%%%  parametros 802.11b
  l =  1500;   % longitud del paquete Ethernet = E[P] en bianchi 
  sigma = 20;  % tiempo en el slot (20microseg)
  cabPHY = 192; % 192microseg 
  cabMAC = (28*8)/11; % se Tx a 11mpbs
  ack = 192 + (14*8)/(2); % %se Tx a 2mpbs
   
  H = cabPHY + cabMAC;
  SIFS = 10 % 10microseg
  DIFS = 50 % 50microseg


  Te = H + l + SIFS  + ack + DIFS + 2; % Duracion de una transmision exitosa. despreciamos delta (propagation delay, de esta ecuación).
  Tc = H + l + DIFS + 1; % Duracion de una transmision sin exito (colision)

  S(N) = (pexito*ptransmision*l)/(((1-ptransmision)*sigma) + (ptransmision*pexito*Te) + (ptransmision*(1-pexito)*Tc))
  % NOS puede dar por encima por cabeceras que hemos omitido.
end
plot(S)


%%%%% PARA HACER:
%
% DARLE MAS ARGUMENTOS DE ENTRADA A LA FUNCION sistema_no_lineal pasarle N y que la llamada a esta funcion este
% dentro del for de N, para que vaya cambiando para cada fuente.
%
%
%
%
%