% clear;
dirName = 'Compare';
listing=dir(dirName);


b = [];    
for i=1:16
    s = sprintf('R3-MUE:%d,5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    C = QFinal.mue.C_profile;
    cc = sum(C(40000:size(C,2)))/(-40000+size(C,2));
    b = [b cc];
end

%%
dirName = 'fairResults';
listing=dir(dirName);


a = [];    
for i=1:16
    s = sprintf('R_pi_beta2:%d,Real:5000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    C = QFinal.mue.C_profile;
    cc = sum(C(40000:size(C,2)))/(-40000+size(C,2));
    a = [a cc];
end

% figure;
hold on;
grid on;
plot( ones(1,16)*1.4005, '--k' );
plot(a, '--*r');
plot(b, '--*b');
% title(fprintf('FUE Number %d', j));
xlabel('FBS Numbers');
ylabel('Capacity(b/s/HZ)');
% axis([0 16 0 5])
% saveas(gcf,sprintf('FUE_Number_%d.jpg', j))
