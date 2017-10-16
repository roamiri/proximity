clear;
dirName = 'R3';
listing=dir(dirName);

R3 = [];    
for i=1:16
    s = sprintf('R3-shared:3,%d,5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    R3 = [R3 QFinal.min_CFUE];
end
comMinFUE.R3=R3;
%%
% dirName = 'Compare';
% listing=dir(dirName);
% 
% myCombine = [];    
% for i=1:16
%     s = sprintf('R_piCombine:%d,Real:10000.mat',i);
%     filename = strcat(dirName , '/', s);
%     load(filename);
%     myCombine = [myCombine QFinal.min_CFUE];
% end
% comMinFUE.myCombine=myCombine;
%%
dirName = 'nopunish';
listing=dir(dirName);

share = [];    
for i=1:16
    s = sprintf('R_nopunish_mix_L:3,%d,Real:1000',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    share = [share QFinal.min_CFUE];
end
comMinFUE.myshare=share;

%%
% dirName = 'nopunish_3';
% listing=dir(dirName);
% 
% myBeta = [];    
% for i=1:16
%     s = sprintf('R_nopunish_2:%d,Real:5000',i);
%     filename = strcat(dirName , '/', s);
%     load(filename);
%     myBeta = [myBeta QFinal.min_CFUE];
% end
% comMinFUE.myBeta=myBeta;
%%
% dirName = 'fairResults';
% listing=dir(dirName);
% 
% thresh = [];    
% for i=1:16
%     s = sprintf('R_pi_beta:%d,Real:1000,thresh:1.00.mat',i);
%     filename = strcat(dirName , '/', s);
%     load(filename);
%     thresh = [thresh QFinal.min_CFUE];
% end
% comMinFUE.thresh=thresh;
% %%
% save(sprintf('Compare/comMinFUE.mat'),'comMinFUE');
%%
figure;
hold on;
grid on;
box on;
plot( ones(1,16)*1.25, '--k' , 'LineWidth',1);
plot(share, '--*r', 'LineWidth',1,'MarkerSize',10);
plot(R3, '--sb', 'LineWidth',1,'MarkerSize',10);
% plot(comMinFUE.myBeta, '--*g');
% plot(comMinFUE.myCombine, '--*m');
% plot(comMinFUE.thresh, '--*c');
title('Minimum Capacity of FUEs','FontSize',14, 'FontWeight','bold');
xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
ylabel('Capacity(b/s/HZ)','FontSize',14, 'FontWeight','bold');
legend({'threshold','RF1','RF2'},'FontSize',14, 'FontWeight','bold');
% saveas(gcf,sprintf('FUE_Number_%d.jpg', j))
axis([4 16 0 4])