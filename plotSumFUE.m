clear;
dirName = 'Compare';
listing=dir(dirName);

R3 = [];    
for i=1:16
    s = sprintf('R3-MUE:%d,5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    R3 = [R3 QFinal.sum_CFUE];
end
comSumFUE.R3=R3;
%%
dirName = 'Compare';
listing=dir(dirName);

myCombine = [];    
for i=1:16
    s = sprintf('R_piCombine:%d,Real:10000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    myCombine = [myCombine QFinal.sum_CFUE];
end
comSumFUE.myCombine=myCombine;
%%
dirName = 'myResults5_K';
listing=dir(dirName);

myK = [];    
for i=1:16
    s = sprintf('R_pi_K:%d,Real:100000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    myK = [myK QFinal.sum_CFUE];
end
comSumFUE.myK=myK;

%%
dirName = 'myResults5_beta';
listing=dir(dirName);

myBeta = [];    
for i=1:16
    s = sprintf('R_pi_beta:%d,Real:100000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    myBeta = [myBeta QFinal.sum_CFUE];
end
comSumFUE.myBeta=myBeta;
%%
dirName = 'Compare';
listing=dir(dirName);

low = [];    
for i=1:16
    s = sprintf('upperBound:%d,Real:10000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    low = [low QFinal.sum_CFUE];
end
comSumFUE.low=low;
%%
save(sprintf('Compare/comSumFUE.mat'),'comSumFUE');
%%
figure;
hold on;
grid on;
plot( ones(1,16)*1.25, '--k' );
plot(comSumFUE.myK, '--*g');
plot(comSumFUE.R3, '--*b');
plot(comSumFUE.myBeta, '--*r');
plot(comSumFUE.myCombine, '--*m');
plot(comSumFUE.low, '--*c');
% title(fprintf('FUE Number %d', j));
xlabel('FBS Numbers');
ylabel('Capacity(b/s/HZ)');
% saveas(gcf,sprintf('FUE_Number_%d.jpg', j))
% axis([0 16 0 10])