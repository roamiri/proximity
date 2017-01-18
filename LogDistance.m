function L = LogDistance(d)
    PL0 = 62.3; d0 = 5; gamma = 4;
    L = PL0 + 10*gamma+log10(d/d0);% +Xg = shadowing effect, but I did not consider it
end