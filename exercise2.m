clear all
close all

fun = @sistema_no_lineal;
x0=[0,0]
sol=fsolve(fun,x0)
p = sol(1)
tau = sol (2)

%%%%%%  parametros paper bainchi %%%%%
%todas las cabeceras se trasmiten a 1Mbps
Payload_b = 8184;   % longitud del paquete en bianchi 
sigma_b  = 50;  % tiempo en el slot (50microseg)
cabPHY_b = 192; % 192microseg 
cabMAC_b = 272; % 
ack_b =  112+cabPHY_b; 
ret_prop_b=1;%%%1microseg
H_b = cabPHY_b + cabMAC_b;
RTS_b=160+cabPHY_b;
CTS_b=112+cabPHY_b;
SIFS_b = 28 
DIFS_b = 128



%duracion de una trasmision exitosa para acceso basico
  Te_b = H_b + Payload_b + SIFS_b  + ack_b + DIFS_b + 2; % Duracion de una transmision exitosa. despreciamos delta (propagation delay, de esta ecuaciÃ³n).
  Tc_b = H_b + Payload_b + DIFS_b + 1; % Duracion de una transmision sin exito (colision)
%%%%%%duracion de una trasmision exitosa RTS/CTS%%%%%%%
  Te_RTS_b=RTS_b +SIFS_b + 1 + CTS_b + SIFS_b +1 +H_b +Payload_b+ SIFS_b+ 1 + ack_b+DIFS_b+1 ;
  Tc_RTS_b=RTS_b + DIFS_b + 1;

%%%%%%BIANCHI
for N=1:60

  pexito = (N*tau*(1-tau)^(N-1))/(1-((1-tau)^N)) % probabilidad de exito
  ptransmision = 1-((1-tau)^N) % probabilidad de transmision
 
  
  %$$$$$throuput para basico
  S(N) = (pexito*ptransmision*Payload_b)/(((1-ptransmision)*sigma_b) + (ptransmision*pexito*Te_b) + (ptransmision*(1-pexito)*Tc_b));
  
  %$$$$$throuput para RTs/CTS
  D(N) = (pexito*ptransmision*Payload_b)/(((1-ptransmision)*sigma_b) + (ptransmision*pexito*Te_RTS_b) + (ptransmision*(1-pexito)*Tc_RTS_b));
end
plot(S)
grid on
hold on
plot (D)
legend(' basico w=32 m=5',' RTS/CTS w=32 m=5')
title('BIANCHI Básico vs BIANCHI RTS/CTS.')

%%%%%%%%%%PARA 802.11%%%%%%%%%
%%%%%%  parametros 802.11b
Payload =  (1500*8)/11;   % longitud del paquete Ethernet en bits
sigma = 20;  % tiempo en el slot (20microseg)
cabPHY = 192; % 192bits 
cabMAC = (34*8); % se Tx a 1mpbs ¿¿¿11mbps??
ack = (112)/(2); % %se Tx a 2mpbs
H = cabPHY + cabMAC;
SIFS = 10 % 10microseg 
DIFS = 50 % 50microseg 2*slot time+SIFS=2*20+10
RTS=160/2
CTS=112/2

%duracion de una trasmision exitosa para acceso basico
  Te = H_b + Payload + SIFS + ack + DIFS + 2; % Duracion de una transmision exitosa. despreciamos delta (propagation delay, de esta ecuaciÃ³n).
  Tc = H_b + Payload + DIFS + 1; % Duracion de una transmision sin exito (colision)
%%%%%%duracion de una trasmision exitosa RTS/CTS%%%%%%%
  Te_RTS=RTS +SIFS + 1 + CTS + SIFS +1 +H +Payload+ SIFS+ 1 + ack+DIFS+1;
  Tc_RTS=RTS + DIFS + 1;

for N=1:60

  pexito = (N*tau*(1-tau)^(N-1))/(1-((1-tau)^N)) % probabilidad de exito
  ptransmision = 1-((1-tau)^N) % probabilidad de transmision
  
  %$$$$$throuput para basico
  S(N) = (pexito*ptransmision*Payload)/(((1-ptransmision)*sigma) + (ptransmision*pexito*Te) + (ptransmision*(1-pexito)*Tc));
  
  %$$$$$throuput para RTs/CTS
  D(N) = (pexito*ptransmision*Payload)/(((1-ptransmision)*sigma) + (ptransmision*pexito*Te_RTS) + (ptransmision*(1-pexito)*Tc_RTS))
end
figure(2)
plot(S)
grid on
hold on
plot (D)
legend('802.11 basico w=32 m=5','802.11 RTS/CTS w=32 m=5');
title('Bianchi Básico vs RTS/CTS en 802.11b');

%%%%%para ver la variacion del throughput con tau
%%%valores asignados para cada grupo

tau=linspace(0.001,0.1,256);%%%damos 256 valores entre 0 y 0.1
N=[5,10,20,50];
%%%BIANCHI BASICO
for i=1:length(N)
    pexito2(i,:) = (tau.*N(i).*(1-tau).^(N(i)-1))./(1-(1-tau).^N(i));
    ptransmision2(i,:)=1-(1-tau).^N(i);
    T(i,:)=(pexito2(i,:).*ptransmision2(i,:)*Payload_b)./((1-ptransmision2(i,:)).*sigma_b+ptransmision2(i,:).*pexito2(i,:).*Te_b+ptransmision2(i,:).*(1-pexito2(i,:)).*Tc_b);
end
figure(3);
plot(tau,T')
grid on
legend('N=10','N=20','N=30');
title('BIANCHI Básico para diferentes N');

%%%BIANCHI RTS/CTS para diferentes Ns
tau=linspace(0.001,0.1,256);%Para esta grafica en el paper esta entre 0 y 0.25
for i=1:length(N)
    pexito2(i,:) = (tau.*N(i).*(1-tau).^(N(i)-1))./(1-(1-tau).^N(i));
    ptransmision2(i,:)=1-(1-tau).^N(i);
   T(i,:)=(pexito2(i,:).*ptransmision2(i,:)*Payload_b)./((1-ptransmision2(i,:)).*sigma_b+ptransmision2(i,:).*pexito2(i,:).*Te_RTS_b+ptransmision2(i,:).*(1-pexito2(i,:)).*Tc_RTS_b);
  
end
figure(4)
plot(tau,T')
grid on
legend('N=5','N=10','N=20','N=50');
title('BIANCHI RTS/CTS para diferentes N');

%%%802.11 BASICO para diferentes Ns
for i=1:length(N)
    pexito2(i,:) = (tau.*N(i).*(1-tau).^(N(i)-1))./(1-(1-tau).^N(i));
    ptransmision2(i,:)=1-(1-tau).^N(i);
    T(i,:)=(pexito2(i,:).*ptransmision2(i,:)*Payload)./((1-ptransmision2(i,:)).*sigma+ptransmision2(i,:).*pexito2(i,:).*Te+ptransmision2(i,:).*(1-pexito2(i,:)).*Tc);
end
figure(5)
plot(tau,T')
grid on
legend('N=10','N=20','N=30');
title('802.11 Básico para diferentes N');

%%%802.11 RTS para diferentes Ns
for i=1:length(N)
    pexito2(i,:) = (tau.*N(i).*(1-tau).^(N(i)-1))./(1-(1-tau).^N(i));
    ptransmision2(i,:)=1-(1-tau).^N(i);
    T(i,:)=(pexito2(i,:).*ptransmision2(i,:)*Payload)./((1-ptransmision2(i,:)).*sigma+ptransmision2(i,:).*pexito2(i,:).*Te_RTS+ptransmision2(i,:).*(1-pexito2(i,:)).*Tc_RTS);
end
figure(6)
plot(tau,T')
grid on
legend('N=10','N=20','N=30');
title('802.11 RTS/CTS para diferentes N')
