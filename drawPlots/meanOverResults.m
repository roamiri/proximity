
clear;
clc;

%%
MUE_C = [];    
min_FUE = [];
sum_FUE = [];
max_MUE = [];
max_FUE = [];
C_FUE_Mat = cell(1,16);
for i=1:16
    fprintf('FBS num = %d\t', i);
    maxmue = 0.;
    maxfue = 0.;
    mue_C = 0.;
    minfue = 0.;
    sumfue = 0.;
    c_fue_vec = zeros(1,i);
    Cnt = 0;
    lowCnt = 0;

    
    for j=1:100
        s = sprintf('oct19/R_18_CL3/pro_128_%d_%d.mat',i,j);
        filename = strcat(s);
        if exist(s)
            load(filename);
%                 mue_C  = QFinal.mue.C;
%                 cc = sum(C(40000:size(C,2)))/(-40000+size(C,2)+1);
                mue_C = mue_C + QFinal.mue.C;
                sumfue = sumfue + QFinal.sum_CFUE;
                c_fue_vec = c_fue_vec + QFinal.C_FUE;
                Cnt = Cnt+1;
        end
    end
    fprintf('Total Cnt = %d\n',Cnt);
    max_MUE = [max_MUE maxmue];
    max_FUE = [max_FUE maxfue];
    MUE_C = [MUE_C mue_C/Cnt]; 
    sum_FUE = [sum_FUE sumfue/Cnt];
    C_FUE_Mat{i} = c_fue_vec./Cnt;
    min_FUE = [min_FUE min(C_FUE_Mat{i})];
end
%%
MUE_C_ref = [];    
min_FUE_ref = [];
sum_FUE_ref = [];
max_MUE_ref = [];
max_FUE_ref = [];
C_FUE_Mat_ref = cell(1,16);
for i=1:16
    fprintf('FBS num = %d\t', i);
    maxmue = 0.;
    maxfue = 0.;
    mue_C = 0.;
    minfue = 0.;
    sumfue = 0.;
    c_fue_vec = zeros(1,i);
    Cnt = 0;
    lowCnt = 0;
    
    for j=1:100
%         s = sprintf('Rref_1/R3_%d_%d.mat',i,j);
        s = sprintf('oct10/R_18_time/pro_%d_%d.mat',i,j);
        filename = strcat(s);
        if exist(s)
            load(filename);
%                 C = QFinal.mue.C_profile;
%                 cc = sum(C(40000:size(C,2)))/(-40000+size(C,2)+1);
                mue_C = mue_C + QFinal.mue.C;
                sumfue = sumfue + QFinal.sum_CFUE;
                c_fue_vec = c_fue_vec + QFinal.C_FUE;
                Cnt = Cnt+1;
        end
    end
    fprintf('Total Cnt = %d\n',Cnt);
    max_MUE_ref = [max_MUE_ref maxmue];
    max_FUE_ref = [max_FUE_ref maxfue];
    MUE_C_ref = [MUE_C_ref mue_C/Cnt]; 
    sum_FUE_ref = [sum_FUE_ref sumfue/Cnt];
    C_FUE_Mat_ref{i} = c_fue_vec./Cnt;
    min_FUE_ref = [min_FUE_ref min(C_FUE_Mat_ref{i})];
end
%%
figure;
hold on;
grid on;
box on;
plot(ones(1,16)*1.0, '--k', 'LineWidth',1);
plot(MUE_C, '--*r', 'LineWidth',1,'MarkerSize',10);
plot(MUE_C_ref, '--*b', 'LineWidth',1,'MarkerSize',10);
title('MUE capacity','FontSize',14, 'FontWeight','bold');
xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
ylabel('Capacity(b/s/HZ)','FontSize',14, 'FontWeight','bold');
xlim([2 16]);
ylim([0 7]);
legend({'threshold','proposed RF','[9]'},'FontSize',14, 'FontWeight','bold');
%%
figure;
hold on;
grid on;
box on;
plot( ones(1,16)*1.0, '--k', 'LineWidth',1);
for i=1:16
    vec = C_FUE_Mat{i};
    vec_ref = C_FUE_Mat_ref{i};
    for j=1:size(vec,2)
        plot(i,vec(j), '*r', 'LineWidth',1,'MarkerSize',10);
        plot(i,vec_ref(j), '*b', 'LineWidth',1,'MarkerSize',10);
    end
end
plot(min_FUE, '--r', 'LineWidth',1,'MarkerSize',10);
plot(min_FUE_ref, '--b', 'LineWidth',1,'MarkerSize',10);
title('FUEs capacity','FontSize',14, 'FontWeight','bold');
xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
ylabel('Capacity(b/s/HZ)','FontSize',14, 'FontWeight','bold');
xlim([2 16]);
ylim([0 3.5]);
legend({'threshold','proposed RF','[9]'},'FontSize',14, 'FontWeight','bold');
%%
figure;
hold on;
grid on;
box on;
% plot( ones(1,16)*2.0, '--k', 'LineWidth',1 );
plot(sum_FUE, '--*r', 'LineWidth',1,'MarkerSize',10);
plot(sum_FUE_ref, '--*b', 'LineWidth',1,'MarkerSize',10);
title('SUM capacity of FUEs','FontSize',14, 'FontWeight','bold');
xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
ylabel('Capacity(b/s/HZ)','FontSize',14, 'FontWeight','bold');
xlim([2 16]);
% ylim([0 16])
legend({'proposed RF','[9]'},'FontSize',14, 'FontWeight','bold');


%%%
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