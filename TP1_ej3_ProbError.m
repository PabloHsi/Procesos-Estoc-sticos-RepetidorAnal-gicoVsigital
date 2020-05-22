%% Ejercicio 3

clear;

SNR=(-5:1:30);
n=(1:4:25);

%Probabilidad de error digital
p_ed_1=(0.5)*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^1);
p_ed_5=(0.5)*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^5);
p_ed_9=(0.5)*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^9);
p_ed_13=(0.5)*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^13);
p_ed_17=(0.5)*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^17);
p_ed_21=(0.5)*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^21);
p_ed_25=(0.5)*(1-(1-2*qfunc(sqrt(10.^(SNR/10)))).^25);

%Probabilidad de error analogico
for i=1:length(n) %cantidad de funciones dependientes de cada n (7 funciones en este caso)
    %i=1,5,9,13,17,2,25
    for j=1:length(SNR) %evaluacion de la variable SNR
        snr=10^(SNR(j)/10); %SNR en db
        aux=0; 
        
        for k=0:n(i)-1 %se suma n(i) veces n(i)=1,5,9,13,17,2,25
            aux=aux+(1+snr.^-1).^k;  %sumatoria del denominador de la raiz de Q()
        end
        
        p_ea(i,j)=qfunc(sqrt(snr/aux));
    end
    
end

%%

%Grafico SEMILOGY
figure();
%digitales
semilogy(SNR,p_ed_1,'-b','LineWidth',1.3,'DisplayName','P_{e,n=1}^d');
hold on;
semilogy(SNR,p_ed_5,'-g','LineWidth',1.3,'DisplayName','P_{e,n=5}^d');
semilogy(SNR,p_ed_9,'-r','LineWidth',1.3,'DisplayName','P_{e,n=9}^d');
semilogy(SNR,p_ed_13,'-c','LineWidth',1.3,'DisplayName','P_{e,n=13}^d');
semilogy(SNR,p_ed_17,'-m','LineWidth',1.3,'DisplayName','P_{e,n=17}^d');
semilogy(SNR,p_ed_21,'-y','LineWidth',1.3,'DisplayName','P_{e,n=21}^d');
semilogy(SNR,p_ed_25,'-k','LineWidth',1.3,'DisplayName','P_{e,n=25}^d');
%analogicos
semilogy(SNR,p_ea(1,:),'ob','LineWidth',1.5,'DisplayName','P_{e,n=1}^a');
semilogy(SNR,p_ea(2,:),'og','LineWidth',1.5,'DisplayName','P_{e,n=5}^a');
semilogy(SNR,p_ea(3,:),'or','LineWidth',1.5,'DisplayName','P_{e,n=9}^a');
semilogy(SNR,p_ea(4,:),'oc','LineWidth',1.5,'DisplayName','P_{e,n=13}^a');
semilogy(SNR,p_ea(5,:),'om','LineWidth',1.5,'DisplayName','P_{e,n=17}^a');
semilogy(SNR,p_ea(6,:),'oy','LineWidth',1.5,'DisplayName','P_{e,n=21}^a');
semilogy(SNR,p_ea(7,:),'ok','LineWidth',1.5,'DisplayName','P_{e,n=25}^a');
grid on;
grid minor;
title('Probabilidad de error en funcion de SNR, eje y semilog');
xlabel('SNR [dB]');
ylabel('P_{e} (SNR) ');
ylim([1e-6 1e0]);
xlim([-5 25]);
xticks(-5:1:25);
lgd=legend('show', 'Location', 'southwest');
lgd.FontSize = 11;


%Grafico Y lineal
figure();
%digitales
plot(SNR,p_ed_1,'-b','LineWidth',1.3,'DisplayName','P_{e,n=1}^d');
hold on;
plot(SNR,p_ed_5,'-g','LineWidth',1.3,'DisplayName','P_{e,n=5}^d');
plot(SNR,p_ed_9,'-r','LineWidth',1.3,'DisplayName','P_{e,n=9}^d');
plot(SNR,p_ed_13,'-c','LineWidth',1.3,'DisplayName','P_{e,n=13}^d');
plot(SNR,p_ed_17,'-m','LineWidth',1.3,'DisplayName','P_{e,n=17}^d');
plot(SNR,p_ed_21,'-y','LineWidth',1.3,'DisplayName','P_{e,n=21}^d');
plot(SNR,p_ed_25,'-k','LineWidth',1.3,'DisplayName','P_{e,n=25}^d');
%analogicos
plot(SNR,p_ea(1,:),'ob','LineWidth',1.5,'DisplayName','P_{e,n=1}^a');
plot(SNR,p_ea(2,:),'og','LineWidth',1.5,'DisplayName','P_{e,n=5}^a');
plot(SNR,p_ea(3,:),'or','LineWidth',1.5,'DisplayName','P_{e,n=9}^a');
plot(SNR,p_ea(4,:),'oc','LineWidth',1.5,'DisplayName','P_{e,n=13}^a');
plot(SNR,p_ea(5,:),'om','LineWidth',1.5,'DisplayName','P_{e,n=17}^a');
plot(SNR,p_ea(6,:),'oy','LineWidth',1.5,'DisplayName','P_{e,n=21}^a');
plot(SNR,p_ea(7,:),'ok','LineWidth',1.5,'DisplayName','P_{e,n=25}^a');
grid on;
%grid minor;
title('Probabilidad de error en funcion de SNR, ejes lineales');
xlabel('SNR [dB]');
ylabel('P_{e} (SNR) ');
ylim([0 0.5]);
xlim([-5 25]);
lgd=legend('show', 'Location', 'east');
lgd.FontSize = 11;