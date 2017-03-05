% Draw final results
%figure;
hold on;
for i=1:16
    c(i)=QFinal{i}.C;
end
grid on
plot(1:16, c, 'b--square')
% plot(1:16, c, 'r--*');
% axis([1 16 1 3.5])
% plot(1:16, 1.4005, '--k');