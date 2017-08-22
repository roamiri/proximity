function SINR = SINR_FUE_2(G, L, FBS, MBS, sigma2)
    fbsNum = size(FBS,2);
    SINR = zeros(1,fbsNum);
    sigma = 10^((sigma2-30)/10);
    P_interf = 0.0;
    
    for i=1:fbsNum
        for j=1:fbsNum
            if i ~= j
                pAgent = 10^((FBS{j}.P-30)/10);
                P_interf = P_interf + pAgent*(G(j,i)/L(j,i));
            end
        end
        pAgent = 10^((FBS{i}.P-30)/10);
        SINR(i) = (pAgent*(G(i,i)/L(i,i)))/(MBS.P*(G(fbsNum+1,i)/L(fbsNum+1,i))+P_interf+sigma);
    end
end