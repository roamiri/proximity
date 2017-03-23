function SINR = SINR_MUE_3(FBS, BS, mue, sigma2, NumRealization) % inputs are dBm, output is not db
    % compute power of signal at UE received from BS        
        x1 = 10 * randn(1,NumRealization);
        x2 = 10 * randn(1,NumRealization);
        xx = mue.X+x1;
        yy = mue.Y+x2;
        d = sqrt((BS.X-xx).^2+(BS.Y-yy).^2);
        PL_BS = 62.3+40*log10(d/5);
        H = abs((1/sqrt(2)) * (randn(1,NumRealization)+1i*randn(1,NumRealization)));
        pbs = 10.^((BS.P-PL_BS-30)/10);
        hbs = H.^2;
        
        % compute power of interference at UE received from Femtocells
        P_interf = 0;
        f=0.9; % Frequency in GHz
        PLi = -1.8*f^2+10.6*f-5.5;
        H = abs((1/sqrt(2)) * (randn(size(FBS,2),NumRealization)+1i*randn(size(FBS,2),NumRealization)));
        h1mue = H.^2;
        sigma = 10^((sigma2-30)/10);
        for i=1:size(FBS,2)    
            pAgent = FBS{i}.P;
            d = sqrt((FBS{i}.X-xx).^2+(FBS{i}.Y-yy).^2);
            PL0 = 62.3+32.*log10(d/5);
            PL_FB = PL0 + PLi;
            p1(i,:) = 10.^((pAgent-PL_FB-30)/10);
        end
    
%         for j=1:NumRealization
            P_interf = sum(p1.*h1mue,1);
%         end
        SINR = sum((pbs.*hbs)./(P_interf+sigma))/NumRealization;
%         SINR = sum((pbs.*hbs)./(sigma))/NumRealization;
end