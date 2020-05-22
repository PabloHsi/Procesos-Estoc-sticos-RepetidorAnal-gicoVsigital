% Simulacion de Monte Carlo
%
% Idea: P(error) = E[ 1{X != Xdetec} ] 
% Se genera una VA = 1{X != Xdetec} y se toman realizaciones de esta.
% Por LLN la media muestral converge a E[ 1{X != Xdetec} ]  = Pe
%
% Algoritmo de montecarlo_analog()
% -Se genera un bit -A o +A
% -Se usa la forma recursiva para ver la degradacion de señal
% -Se van acumulando la cantidad de veces que 1{X != Xdetec}  = 1
%  y se divide por la cantidad de simulaciones de Monte Carlo. 
%  Esta media muestral deberia converger
%  a la E[ 1{X != Xdetec} ] = P(error).

%%
% Graficos 
clear
target_dB = 5 : 25;
N_repeaters = 9;
N_montecarlo = 500000;

for i = 1 : numel(target_dB)
    prob_values_montecarlo_analog(i) = ...
        montecarlo_analog(target_dB(i), N_montecarlo, N_repeaters);
   
    prob_values_montecarlo_digital(i) = ...
        montecarlo_digital(target_dB(i), N_montecarlo, N_repeaters);
    
        
    % ///////////////////////
    % Valores teoricos
    SNR = 10^(target_dB(i)/10);
    den = 0;
    for k = 0:N_repeaters -1 
        den = den + (1+1/SNR)^k;
    end
    prob_values_analog(i) = qfunc( sqrt( SNR/den ) );  
    prob_values_digital(i) = 1/2*(1 - (1 - 2*qfunc(sqrt(SNR)) )^N_repeaters);
    % //////////////////////        
        
end

figure
semilogy(target_dB, prob_values_montecarlo_analog, '+')
hold on
semilogy(target_dB, prob_values_montecarlo_digital, '*')
% //////////////////////  
semilogy(target_dB, prob_values_analog)
semilogy(target_dB, prob_values_digital)
% //////////////////////  

grid on
title('Probabilidad de error promedio vs SNR')
ylabel('Probabilidad')
xlabel('SNR [dB]')
ylim([1E-6 1])
xlim([5 30])
legend('Analógico por Monte Carlo', 'Digital por Monte Carlo',...
    'Analógico teórico', 'Digital teórico')
hold off