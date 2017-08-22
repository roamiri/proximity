function SINR = SINR_MUE_4(G, L, FBS, MBS, MUE, sigma2)
    fbsNum = size(FBS,2);
    P_interf = 0.0;
    sigma = 10^((sigma2-30)/10);
    mbsP = 10^((MBS.P-30)/10);
    for i=1:fbsNum
        pAgent = 10^((FBS{i}.P-30)/10);
        P_interf = P_interf + pAgent*G(i,fbsNum+1)/L(i,fbsNum+1);
    end
    SINR = (mbsP*G(fbsNum+1,fbsNum+1)/L(fbsNum+1,fbsNum+1))/(P_interf+sigma);
end