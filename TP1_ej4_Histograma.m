%% Histograma vs simulaciones 

% Simulacion caso analogico
clear
SNR_db = 12;
N_montecarlo_samples = 8000;
N_repeaters = 9;

SNR = 10^(SNR_db/10);
amplitude = -5; 


Gh =sqrt(SNR/(SNR+1)); 
G_mod = amplitude/sqrt(SNR+1);

montecarlo_sum = 0;
for i = 1:N_montecarlo_samples
   
    init_bit = amplitude; %condiciono X1 = A 
    signal = init_bit;
    
    for k = 1:N_repeaters
        signal = Gh*signal + G_mod*randn();
    end
  
    histogramdata(i) = signal;
end


%%
% Densidad de Y|x1=A

%%%%%%%% Cuentas AUX
den = 0;
  for k = 0:N_repeaters -1 
        den = den + (1+1/SNR)^k;
  end
rho_n = SNR /den;

den2 = 0;
  for k = 1:N_repeaters  
        den2 = den2 + (SNR/(SNR+1))^(N_repeaters-k);
  end
  den2 = sqrt(den2);
  
den3 = sqrt(1/(SNR+1)); %h
%%%%%%%%%
  
y = -20 : 0.01 : 20;
x = y /(den3*amplitude*den2) - sqrt(rho_n);
  
% se divide por la regla de la cadena al derivar la func. de distrib.
fz = -1/sqrt(2*pi)*exp(-x.^2/2) /(den3*amplitude*den2); 
 

figure
histogram(histogramdata,'Normalization', 'pdf','FaceColor', 'red')
hold on

plot(y,fz, 'black', 'linewidth', 2)
grid on
hold off

title('Función de densidad vs histograma')
ylabel('Densidad')
xlabel('Y|x1=A')
legend('Detección', 'Funcion de densidad', 'Location' ,'northeast')