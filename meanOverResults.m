
clear;
clc;

dirName = 'R_1';
listing=dir(dirName);

MUE_C = [];    
min_FUE = [];
sum_FUE = [];
max_MUE = [];
max_FUE = [];
for i=1:16
    fprintf('FBS num = %d\t', i);
    maxmue = 0.;
    maxfue = 0.;
    mue_C = 0.;
    minfue = 0.;
    sumfue = 0.;
    
    Cnt = 0;
    lowCnt = 0;
    
    for j=1:100
        s = sprintf('R_5/pro_%d_%d.mat',i,j);
        filename = strcat(s);
        if exist(s)
            load(filename);
%             if QFinal.mue.C > 0.20
%                 if maxmue < QFinal.mue.C
%                     maxmue = QFinal.mue.C;
%                 end
%                 if maxfue < QFinal.min_CFUE
%                     maxfue = QFinal.min_CFUE;
%                 end
                C = QFinal.mue.C_profile;
                cc = sum(C(40000:size(C,2)))/(-40000+size(C,2));
                mue_C = mue_C + cc;
                minfue = minfue + QFinal.min_CFUE;
                sumfue = sumfue + QFinal.sum_CFUE;
                Cnt = Cnt+1;
%             else
%                 lowCnt = lowCnt + 1;
%             end
        end
    end
    fprintf('Total Cnt = %d\n',Cnt);
%     fprintf('low Cnt = %d\n',lowCnt);
    max_MUE = [max_MUE maxmue];
    max_FUE = [max_FUE maxfue];
    MUE_C = [MUE_C mue_C/Cnt];
    min_FUE = [min_FUE minfue/Cnt];
    sum_FUE = [sum_FUE sumfue/Cnt];
end
%%
figure;
hold on;
grid on;
box on;
plot( ones(1,16)*1.0, '--k', 'LineWidth',1 );
plot(MUE_C, '--*b', 'LineWidth',1,'MarkerSize',10);
title('MUE capacity in low interference','FontSize',14, 'FontWeight','bold');
xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
ylabel('Capacity(b/s/HZ)','FontSize',14, 'FontWeight','bold');
xlim([2 16]);
% legend({'threshold','RF1','RF2'},'FontSize',14, 'FontWeight','bold');
%%
figure;
hold on;
grid on;
box on;
% plot( ones(1,16)*2.0, '--k', 'LineWidth',1 );
plot(sum_FUE, '--*b', 'LineWidth',1,'MarkerSize',10);
title('SUM capacity of FUEs in low interference','FontSize',14, 'FontWeight','bold');
xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
ylabel('Capacity(b/s/HZ)','FontSize',14, 'FontWeight','bold');
xlim([2 16]);
% legend({'threshold','RF1','RF2'},'FontSize',14, 'FontWeight','bold');
%%
figure;
hold on;
grid on;
box on;
plot( ones(1,16)*1.0, '--k', 'LineWidth',1 );
plot(min_FUE, '--*b', 'LineWidth',1,'MarkerSize',10);
title('min FUE capacity in low interference','FontSize',14, 'FontWeight','bold');
xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
ylabel('Capacity(b/s/HZ)','FontSize',14, 'FontWeight','bold');
xlim([2 16]);
% legend({'threshold','RF1','RF2'},'FontSize',14, 'FontWeight','bold');
% %%
% figure;
% hold on;
% grid on;
% box on;
% plot( ones(2,16)*1.0, '--k', 'LineWidth',1 );
% plot(max_MUE, '--*r', 'LineWidth',1,'MarkerSize',10);
% title('max MUE capacity in high interference','FontSize',14, 'FontWeight','bold');
% xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
% ylabel('Capacity(b/s/HZ)','FontSize',14, 'FontWeight','bold');
% legend({'threshold','RF1','RF2'},'FontSize',14, 'FontWeight','bold');