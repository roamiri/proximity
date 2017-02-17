function SINR = SINR_FUE(FBS, BS, sigma2, NumRealization)
    fbsNum = size(FBS,2);
    PBS = zeros(size(FBS,2), NumRealization);
    sigma = 10^((sigma2-30)/10);
    SINR = zeros(1,fbsNum);
    for j=1:fbsNum
        fbs = FBS{j};
        % compute power of signal at FUE received from BS
        d = sqrt((BS.X-fbs.FUEX)^2+(BS.Y-fbs.FUEY)^2);
        PL_BS = 62.3+40*log10(d/5);
        H = abs((1/sqrt(2)) * (randn(1,NumRealization)+1i*randn(1,NumRealization)));
        pbs = 10^((BS.P-PL_BS-30)/10);
        hbs = H.^2;
        PBS(j,:) = pbs.*hbs;
    end
    
    % compute power of interference at UE received from Femtocells
    
    Hij = abs((1/sqrt(2)) * (randn(fbsNum, fbsNum, NumRealization)+1i*randn(fbsNum, fbsNum, NumRealization)));
    hij = Hij.^2;
    P_interface = zeors(1,NumRealization);
    Pij = zeros(fbsNum,fbsNum);
    for i=1:fbsNum
        pAgent = FBS{i}.P;
        xAgent = FBS{i}.X;
        yAgent = FBS{i}.Y;
        for j=1:fbsNum
            d = sqrt((xAgent-FBS{j}.FUEX)^2+(yAgent-FBS{j}.FUEY)^2);
            PL0 = 62.3+32*log10(d/5);
            Pij(i,j) = 10^((pAgent-PL0-30)/10);
        end
    end
    
    for i=1:fbsNum
        for j=1:fbsNum
            if i~=j
                P_interface(1,:) = P_interface(1,:) + Pij(j,i).*hij(j,i,:);
            end
        end
        SINR(i) = sum((Pij(i,i).*hij(i,i,:))./(PBS(i,:)+P_interface+sigma))/NumRealization;
    end
end