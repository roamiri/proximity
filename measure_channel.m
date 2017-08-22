function [G, L] = measure_channel(FBS,MBS,MUE,NumRealization)
    fbsNum = size(FBS,2);
    G = zeros(fbsNum+1, fbsNum+1);
    L = zeros(fbsNum+1, fbsNum+1);
    f=0.9; % Frequency in GHz
    PLi = -1.8*f^2+10.6*f-5.5;
    for i=1:fbsNum
        xAgent = FBS{i}.X;
        yAgent = FBS{i}.Y;
        for j=1:fbsNum
            d = sqrt((xAgent-FBS{j}.FUEX)^2+(yAgent-FBS{j}.FUEY)^2);
            if i==j
                PL0 = 62.3+40*log10(d/5);
                L(i,j) = 10^((PL0)/10);
            else
                PL0 = 62.3+32*log10(d/5);
                L(i,j) = 10^((PL0+PLi)/10);
            end        
        end
        d = sqrt((xAgent-MUE.X)^2+(yAgent-MUE.Y)^2);
        PL0 = 62.3+32.*log10(d/5);
        L(i,fbsNum+1) = 10.^((PL0 + PLi)/10);
        
        d = sqrt((MBS.X-FBS{i}.FUEX)^2+(MBS.Y-FBS{i}.FUEY)^2);
        PL_BS = 62.3+32*log10(d/5);
        L(fbsNum+1,i) = 10^((PL_BS+PLi)/10);
    end
    d = sqrt((MBS.X-MUE.X).^2+(MBS.Y-MUE.Y).^2);
    PL_BS = 62.3+40*log10(d/5);
    L(fbsNum+1,fbsNum+1) = 10.^((PL_BS)/10);
    
    Hij = abs((1/sqrt(2)) * (randn(fbsNum+1, fbsNum+1, NumRealization)+1i*randn(fbsNum+1, fbsNum+1, NumRealization)));
    hij = Hij.^2;
    for i=1:fbsNum+1
        for j=1:fbsNum+1
            G(i,j)=(sum(hij(i,j,:))/NumRealization);
        end
    end
end