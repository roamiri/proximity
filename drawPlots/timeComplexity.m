
clear;
clc;
%%
T_vec = [];
for i=1:16
    fprintf('FBS num = %d\t', i);
    Cnt = 0;
    T = 0.0;
    
    for j=1:100
        s = sprintf('oct27/R_18_CL3/pro_32_%d_%d.mat',i,j);
        filename = strcat(s);
        if exist(s)
            load(filename);
            T = T + QFinal.time;
            Cnt = Cnt+1;
        end
    end
    fprintf('Total Cnt = %d\n',Cnt);
    T_vec = [T_vec T/(i*Cnt)];
end
%%
figure;
hold on;
grid on;
box on;
plot(T_vec, '--*r', 'LineWidth',1,'MarkerSize',10);
title('Time duration of proposed RF','FontSize',14, 'FontWeight','bold');
xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
ylabel('seconds','FontSize',14, 'FontWeight','bold');
xlim([2 15]);
% ylim([3e4 5e4]);
% legend({'proposed RF','[9]'},'FontSize',14, 'FontWeight','bold');