clear;
dirName = 'Compare/';
listing=dir(dirName);

R3 = [];    
for i=1:16
    s = sprintf('R3-MUE:%d,5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    R3 = [R3 QFinal.min_CFUE];
end
comMinFUE.R3=R3;
%%
dirName = 'Compare';
listing=dir(dirName);

myCombine = [];    
for i=1:16
    s = sprintf('R_piCombine:%d,Real:10000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    myCombine = [myCombine QFinal.min_CFUE];
end
comMinFUE.myCombine=myCombine;
%%
dirName = 'myResults5_K';
listing=dir(dirName);

myBeta = [];    
for i=1:16
    s = sprintf('R_pi_K:%d,Real:100000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    myBeta = [myBeta QFinal.min_CFUE];
end
comMinFUE.myK=myBeta;

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
dirName = 'Compare';
listing=dir(dirName);

low = [];    
for i=1:16
    s = sprintf('upperBound:%d,Real:10000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    low = [low QFinal.min_CFUE];
end
comMinFUE.low=low;
%%
save(sprintf('Compare/comMinFUE.mat'),'comMinFUE');
%%
figure;
hold on;
grid on;
plot( ones(1,16)*1.25, '--k' );
% plot(comMinFUE.myK, '--*g');
plot(comMinFUE.R3, '--*b');
plot(comMinFUE.myBeta, '--*r');
% plot(comMinFUE.myCombine, '--*m');
% plot(comMinFUE.low, '--*c');
% title(fprintf('FUE Number %d', j));
xlabel('FBS Numbers');
ylabel('Capacity(b/s/HZ)');
% saveas(gcf,sprintf('FUE_Number_%d.jpg', j))
axis([0 16 0 10])