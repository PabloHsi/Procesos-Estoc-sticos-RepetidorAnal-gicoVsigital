function prob_error = montecarlo_analog(SNR_db ,N_montecarlo_samples, N_repeaters)

% Devuelve la probabilidad de error del caso analogico
% mediante simulacion de Monte Carlo


SNR = 10^(SNR_db/10);


% La amplitud es arbitraria, el ruido esta vinculado a esto por la SNR
amplitude = 5; 

% Expresion (2) del informe
Gh =sqrt(SNR/(SNR+1)); 

% En cada etapa el ruido ~N(0,sigma^2) esta multiplicado por
% una ganancia Gn tal que el ruido final es ~N(0,sigma^2 Gn^2).
% O sea G_mod = sigma*Gn
G_mod = amplitude/sqrt(SNR+1);


montecarlo_sum = 0;

for i = 1:N_montecarlo_samples
   
    % Lo del parentesis vale 1 o -1
    init_bit = amplitude * (2* (rand()>0.5) -1 );
    signal = init_bit;
    
    for k = 1:N_repeaters
        signal = Gh*signal + G_mod*randn();
    end

    
    if(signal > 0 && init_bit < 0  ||  signal < 0 && init_bit > 0)
        montecarlo_sum = montecarlo_sum +1;
    end
    
end

prob_error = montecarlo_sum / N_montecarlo_samples;