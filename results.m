% Draw final results
%figure;
hold on;
for i=1:16
    c(i)=QFinal{i}.C;
end
grid on
plot(1:16, c, 'r--*')