clear;
dirName = 'final_3';
listing=dir(dirName);

R3 = [];    
for i=1:16
    s = sprintf('R3-shared:%d,5000.mat',i);
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
dirName = 'final_3';
listing=dir(dirName);

share = [];    
for i=1:16
    s = sprintf('R_share_beta:%d,Real:5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    share = [share QFinal.min_CFUE];
end
comMinFUE.myshare=share;

%%
dirName = 'fairResults';
listing=dir(dirName);

myBeta = [];    
for i=1:16
    s = sprintf('R_pi_beta2:%d,Real:5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    myBeta = [myBeta QFinal.min_CFUE];
end
comMinFUE.myBeta=myBeta;
%%
dirName = 'fairResults';
listing=dir(dirName);

thresh = [];    
for i=1:16
    s = sprintf('R_pi_beta:%d,Real:1000,thresh:1.00.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    thresh = [thresh QFinal.min_CFUE];
end
comMinFUE.thresh=thresh;
%%
save(sprintf('Compare/comMinFUE.mat'),'comMinFUE');
%%
figure;
hold on;
grid on;
plot( ones(1,16)*1.25, '--k' );
plot(share, '--*r');
plot(R3, '--sb');
% plot(comMinFUE.myBeta, '--*r');
% plot(comMinFUE.myCombine, '--*m');
% plot(comMinFUE.thresh, '--*c');
% title(fprintf('FUE Number %d', j));
xlabel('FBS Numbers');
ylabel('Capacity(b/s/HZ)');
% saveas(gcf,sprintf('FUE_Number_%d.jpg', j))
% axis([0 16 0 10])