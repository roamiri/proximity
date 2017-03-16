% clear;
dirName = 'Compare';
listing=dir(dirName);


a = [];    
for i=1:16
    s = sprintf('upperBound:%d,Real:1000.mat',i);
    filename = strcat(dirName , '/', s);
    load(filename);
    a = [a QFinal.mue.C];
end

% figure;
hold on;
grid on;
plot( ones(1,16)*1.4005, '--k' );
plot(a, '--*r');
% title(fprintf('FUE Number %d', j));
xlabel('FBS Numbers');
ylabel('Capacity(b/s/HZ)');
% axis([0 16 0 5])
% saveas(gcf,sprintf('FUE_Number_%d.jpg', j))
