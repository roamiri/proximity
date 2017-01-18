function L=empiricalLoss(f)
    p1 = -1.8; p2 = 10.6;
    p3 = 5.8 * 2 - 5.5; % P3 = alpha * Nw + beta
    L = p1*f^2 + p2*f + p3;
end