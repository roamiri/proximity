clear;
dirName = 'final_3';
listing=dir(dirName);

R3 = [];    
for i=1:16
    s = sprintf('R3-shared:%d,5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    
    for j=1:size(QFinal.FBS,2)
        C = QFinal.FBS{1,j}.C_profile;
        c_fue(1,j) = sum(C(40000:size(C,2)))/(-40000+size(C,2));
    end
    sum_CFUE = 0.0;
    for i=1:size(QFinal.FBS,2)
        sum_CFUE = sum_CFUE + c_fue(1,i);
    end
    R3 = [R3 sum_CFUE];
end
comSumFUE.R3=R3;
%%
dirName = 'final_3';
listing=dir(dirName);

share = [];    
for i=1:16
    s = sprintf('R_share_beta:%d,Real:5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    share = [share QFinal.sum_CFUE];
end
comSumFUE.share=share;

%%
dirName = 'fairResults';
listing=dir(dirName);

myBeta = [];    
for i=1:16
    s = sprintf('R_pi_beta2:%d,Real:5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    myBeta = [myBeta QFinal.sum_CFUE];
end
comSumFUE.myBeta=myBeta;
%%
dirName = 'fairResults';
listing=dir(dirName);

thresh = [];    
for i=1:16
    s = sprintf('R_pi_beta:%d,Real:1000,thresh:1.00.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    thresh = [thresh QFinal.sum_CFUE];
end
comSumFUE.thresh=thresh;
%%
save(sprintf('Compare/comSumFUE.mat'),'comSumFUE');
%%
figure;
hold on;
grid on;
% plot( ones(1,16)*1.25, '--k' );
plot(share, '--*r');
plot(R3, '--*b');
% plot(comSumFUE.myBeta, '--*r');
% plot(comSumFUE.myCombine, '--*m');
% plot(comSumFUE.thresh, '--*c');
% title(fprintf('FUE Number %d', j));
xlabel('FBS Numbers');
ylabel('Capacity(b/s/HZ)');
% saveas(gcf,sprintf('FUE_Number_%d.jpg', j))
% axis([0 16 0 10])