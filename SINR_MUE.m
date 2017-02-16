function SINR = SINR_MUE(FBS, BS, mue, sigma2, NumRealization) % inputs are dBm, output is not db
    sinr_sum = 0;
    for j=1:NumRealization
        % compute power of signal at UE received from BS
        d = sqrt((BS.X-mue.X)^2+(BS.Y-mue.Y)^2);
        PL_BS = 62.3+40*log10(d/5);
        H = abs((1/sqrt(2)) * (randn(1)+1i*randn(1)));
        pbs = 10^((BS.P-PL_BS-30)/10);
        hbs = H^2;

        % compute power of interference at UE received from Femtocells
        P_interf = 0;
        f=0.9; % Frequency in GHz
        PLi = -1.8*f^2+10.6*f-5.5;
        for i=1:size(FBS,2)
            H = abs((1/sqrt(2)) * (randn(1)+1i*randn(1)));
            h1mue = H^2;
            pAgent = FBS{i}.P;
            d = sqrt((FBS{i}.X-mue.X)^2+(FBS{i}.Y-mue.Y)^2);
            PL0 = 62.3+32*log10(d/5);
            PL_FB = PL0 + PLi;
            p1 = 10^((pAgent-PL_FB-30)/10);
            P_interf = P_interf + p1*h1mue;
        end
        sigma = 10^((sigma2-30)/10);
        sinr_sum = sinr_sum + (pbs*hbs)/(P_interf+sigma);
    end
    SINR = sinr_sum / NumRealization;
end