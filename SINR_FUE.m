function SINR = SINR_FUE(FBS, BS, sigma2, NumRealization)
    sinr_sum = 0;
    for j=1:size(FBS,2)
        fbs = FBS{j};
        % compute power of signal at UE received from BS
        d = sqrt((BS.X-fbs.FUEX)^2+(BS.Y-fbs.FUEY)^2);
        PL_BS = 62.3+40*log10(d/5);
        H = abs((1/sqrt(2)) * (randn(1)+1i*randn(1)));
        pbs = 10^((BS.P-PL_BS-30)/10);
        hbs = H^2;

        % compute power of interference at UE received from Femtocells
        P_interf = 0;
        for i=1:size(FBS,2)
            if i ~= j
                H = abs((1/sqrt(2)) * (randn(1)+1i*randn(1)));
                h1mue = H^2;
                pAgent = FBS{i}.P;
                d = sqrt((FBS{i}.X-fbs.FUEX)^2+(FBS{i}.Y-fbs.FUEY)^2);
                PL0 = 62.3+32*log10(d/5);
                p1 = 10^((pAgent-PL0-30)/10);
                P_interf = P_interf + p1*h1mue;
            end
        end
        
        H = abs((1/sqrt(2)) * (randn(1)+1i*randn(1)));
        hj = H^2;
        pAgent = fbs.P;
        d = fbs.dFUE;
        PL0 = 62.3+32*log10(d/5);
        pj = 10^((pAgent-PL0-30)/10);
        sigma = 10^((sigma2-30)/10);
        SINR(j) = (pj*hj)/(pbs*hbs+P_interf+sigma);
        
    end
%     SINR = sinr_sum / NumRealization;
end