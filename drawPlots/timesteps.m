
clear;
clc;
%%
Episode_vec = [];
for i=1:16
    fprintf('FBS num = %d\t', i);
    Cnt = 0;
    episodes = 0;
    
    for j=1:100
        s = sprintf('oct17/R_18_CL2/pro_%d_%d.mat',i,j);
        filename = strcat(s);
        if exist(s)
            load(filename);
            C = QFinal.mue.C_profile;
            episodes = episodes + size(C,2);
            Cnt = Cnt+1;
        end
    end
    fprintf('Total Cnt = %d\n',Cnt);
    Episode_vec = [Episode_vec episodes/Cnt];
end
%%
Episode_vec_refNoshare = [];
for i=1:16
    fprintf('FBS num = %d\t', i);
    Cnt = 0;
    episodes = 0;
    
    for j=1:100
        s = sprintf('oct17/R_18_CL/pro_%d_%d.mat',i,j);
        filename = strcat(s);
        if exist(s)
            load(filename);
            episodes = episodes + QFinal.episode;
            Cnt = Cnt+1;
        end
    end
    fprintf('Total Cnt = %d\n',Cnt);
    Episode_vec_refNoshare = [Episode_vec_refNoshare episodes/Cnt];
end
%%
Episode_vec_noshare = [];
for i=1:16
    fprintf('FBS num = %d\t', i);
    Cnt = 0;
    episodes = 0;
    
    for j=1:100
        s = sprintf('oct10/R_18_noshare/pro_%d_%d.mat',i,j);
        filename = strcat(s);
        if exist(s)
            load(filename);
            C = QFinal.mue.C_profile;
            episodes = episodes + size(C,2);
            Cnt = Cnt+1;
        end
    end
    fprintf('Total Cnt = %d\n',Cnt);
    Episode_vec_noshare = [Episode_vec_noshare episodes/Cnt];
end
%%
figure;
hold on;
grid on;
box on;
plot(Episode_vec, '--*r', 'LineWidth',1,'MarkerSize',10);
plot(Episode_vec_refNoshare, '--*b', 'LineWidth',1,'MarkerSize',10);
% plot(Episode_vec_noshare, '--*g', 'LineWidth',1,'MarkerSize',10);
title('Search time complexity','FontSize',14, 'FontWeight','bold');
xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
ylabel('Number of iterations','FontSize',14, 'FontWeight','bold');
xlim([2 16]);
ylim([3e4 5e4]);
legend({'proposed RF','[9]'},'FontSize',14, 'FontWeight','bold');
