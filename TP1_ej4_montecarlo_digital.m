function prob_error = montecarlo_digital(SNR_db ,N_montecarlo_samples, N_repeaters)

% Devuelve la probabilidad de error usando los repetidores analogicos
% usando simulaciones por Monte Carlo.
format long

SNR = 10^(SNR_db/10);

amplitude = 5;

Gh = sqrt(SNR/(SNR+1)); 
G_mod = amplitude/sqrt(SNR+1);

montecarlo_sum = 0;
for i = 1:N_montecarlo_samples
   
    if(rand()>0.5)
        init_bit = amplitude;
    else
        init_bit = -amplitude;
    end
    
    signal = init_bit;
    
    for k = 1:N_repeaters
        signal = Gh*signal + G_mod*randn();
        
        % Repetidor digital regenera la senal
        if(signal > 0)
            signal = amplitude;
        else
            signal = -amplitude;
        end
        
    end
    
    
    if(signal > 0 && init_bit < 0  ||  signal < 0 && init_bit > 0)
        montecarlo_sum = montecarlo_sum +1;
    end
    
end

prob_error = montecarlo_sum / N_montecarlo_samples;

