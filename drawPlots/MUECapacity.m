% clear;
dirName = 'R3';
listing=dir(dirName);


R3 = [];    
for i=1:16
    s = sprintf('R3-shared:3,%d,5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    C = QFinal.mue.C_profile;
    cc = sum(C(40000:size(C,2)))/(-40000+size(C,2));
    R3 = [R3 cc];
end

%%
dirName = 'nopunish';
listing=dir(dirName);


mine = [];    
for i=1:16
    s = sprintf('R_nopunish_mix_L:3,%d,Real:1000',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    C = QFinal.mue.C_profile;
    cc = sum(C(40000:size(C,2)))/(-40000+size(C,2));
    mine = [mine cc];
end
%%
% dirName = 'nopunish_3';
% listing=dir(dirName);
% 
% 
% mine2 = [];    
% for i=1:16
%     s = sprintf('R_nopunish_2:%d,Real:5000',i);
%     filename = strcat(dirName , '/', s);
%     load(filename);
%     C = QFinal.mue.C_profile;
%     cc = sum(C(40000:size(C,2)))/(-40000+size(C,2));
%     mine2 = [mine2 cc];
% end
%%
figure;
hold on;
grid on;
box on;
plot( ones(1,16)*1.4005, '--k', 'LineWidth',1 );
plot(mine, '--*r', 'LineWidth',1,'MarkerSize',10);
plot(R3, '--sb','LineWidth',1,'MarkerSize',10);
% plot(mine2, '--*g');
title('MUE capacity in low interference','FontSize',14, 'FontWeight','bold');
xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
ylabel('Capacity(b/s/HZ)','FontSize',14, 'FontWeight','bold');
legend({'threshold','RF1','RF2'},'FontSize',14, 'FontWeight','bold');
% axis([0 16 0 5])
% saveas(gcf,sprintf('FUE_Number_%d.jpg'))
