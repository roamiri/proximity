clear;
dirName = 'myResults5_beta/';
listing=dir(dirName);

for j=1:15
a = [];    
for i=3:size(listing,1)
    filename = strcat(dirName , '/', listing(i).name);
    load(filename);
    if size(QFinal.C_FUE,2)>=j
        a = [a QFinal.C_FUE(j)];
    else
        a = [a 0];
    end
end
b = [a(1) a(8:15) a(2:7)];
figure;
hold on;
grid on;
plot( ones(1,16)*1.25, '--k' );
plot(b, '--*b');
title(sprintf('FUE Number %d', j));
xlabel('FBS Numbers');
ylabel('Capacity(b/s/HZ)');
saveas(gcf,sprintf('FUE_Number_%d.jpg', j))
end