function SINR = SINR_FUE_2(G, L, FBS, MBS, sigma2)
    MBS_P = MBS.P;
    fbsNum = size(FBS,2);
    SINR = zeros(1,fbsNum);
    sigma = 10^((sigma2-30)/10);
    P_interf = 0.0;
    pAgent = zeros(1,fbsNum);
    for i=1:fbsNum
        pAgent(i) = 10.^((FBS{i}.P-30)/10);
    end
    
    for i=1:fbsNum
        for j=1:fbsNum
            if i ~= j
                P_interf = P_interf + pAgent(j)*(G(j,i)/L(j,i));
            end
        end
        SINR(i) = (pAgent(i)*(G(i,i)/L(i,i)))/(MBS_P*(G(fbsNum+1,i)/L(fbsNum+1,i))+P_interf+sigma);
    end
end