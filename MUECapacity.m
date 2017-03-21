% clear;
dirName = 'final_3';
listing=dir(dirName);


R3 = [];    
for i=1:16
    s = sprintf('R3-shared:%d,5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    C = QFinal.mue.C_profile;
    cc = sum(C(40000:size(C,2)))/(-40000+size(C,2));
    R3 = [R3 cc];
end

%%
dirName = 'final_3';
listing=dir(dirName);


mine = [];    
for i=1:16
    s = sprintf('R_share_beta:%d,Real:5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    C = QFinal.mue.C_profile;
    cc = sum(C(40000:size(C,2)))/(-40000+size(C,2));
    mine = [mine cc];
end
%%
dirName = 'fairResults';
listing=dir(dirName);


e = [];    
for i=1:15
    s = sprintf('R_share_beta2:%d,Real:1000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    C = QFinal.mue.C_profile;
    cc = sum(C(40000:size(C,2)))/(-40000+size(C,2));
    e = [e cc];
end
%%
figure;
hold on;
grid on;
plot( ones(1,16)*1.4005, '--k' );
% plot(e, '--*g');
plot(mine, '--*r');
plot(R3, '--*b');
% title(fprintf('FUE Number %d', j));
xlabel('FBS Numbers');
ylabel('Capacity(b/s/HZ)');
% axis([0 16 0 5])
% saveas(gcf,sprintf('FUE_Number_%d.jpg', j))
