clear;
dirName = 'myResults5_beta/';
listing=dir(dirName);


a = [];    
for i=3:size(listing,1)
    filename = strcat(dirName , '/', listing(i).name);
    load(filename);
    a = [a QFinal.mue.C];
end
b = [a(1) a(8:15) a(2:7)];
figure;
hold on;
grid on;
plot( ones(1,16)*1.4005, '--k' );
plot(b, '--*b');
% title(fprintf('FUE Number %d', j));
xlabel('FBS Numbers');
ylabel('Capacity(b/s/HZ)');
% saveas(gcf,sprintf('FUE_Number_%d.jpg', j))
