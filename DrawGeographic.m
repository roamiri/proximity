%%
figure;
hold on;
grid on;

dM1 = 15; dM2 = 50; dM3 = 125; 
dB1 = 50; dB2 = 150; dB3 = 400;
BS = BaseStation(0 , 0 , 50);
FBS = QFinal{16}.FBS;
for i=1:16
    fbs = FBS{i};
    p = plot(fbs.X, fbs.Y, 'r');
    p.Marker = '*';
    p = plot(fbs.X, fbs.Y+10, 'k');
    p.Marker = 'x';
    
%     ss = size(fbs.powerProfile,2);
%     txt1 = sprintf('%.1f',fbs.powerProfile(ss-10));
%     text(fbs.X, fbs.Y-5,txt1)    
end
axis([-300,350,-100,350]);

p = plot(BS.X, BS.Y, 'b');
p.Marker = 'diamond';
circle(BS.X,BS.Y,dB1, 'b');
circle(BS.X,BS.Y,dB2, 'b');
circle(BS.X,BS.Y,dB3, 'b');
selectedMUE.X = 204;
selectedMUE.Y = 207;
p = plot(selectedMUE.X, selectedMUE.Y, 'k');
p1 = plot(150, 150, 'k');
p2 = plot(-200, 0, 'k');
p.Marker = 'square';
p1.Marker = 'square';
p2.Marker = 'square';
circle(selectedMUE.X,selectedMUE.Y,dM1, 'r');
circle(selectedMUE.X,selectedMUE.Y,dM2, 'r');
circle(selectedMUE.X,selectedMUE.Y,dM3, 'r');

title('System Model');
xlabel('x position');
ylabel('y position');
% 
% text(-250, 270, 'd', 'Color', 'b');
% text(-230, 270, 'BS');
% 
% text(-250, 250, '*', 'Color', 'r');
% text(-230, 250, 'FBS');
% 
% text(-250, 230, 'x', 'Color', 'k');
% text(-230, 230, 'FUE');
% 
% text(-250, 210, 's', 'Color', 'r');
% text(-230, 210, 'MUE');

ht = text(-230, 270, {'{\color{blue} d } BS', '{\color{red} * } FBS', '{\color{black} x } FUE' , '{\color{black} s } MUE'}, 'EdgeColor', 'k');
% ht = text(-230, 270, {'{\color{blue} d } BS', '{\color{red} * } FBS','{\color{black} s } MUE'}, 'EdgeColor', 'k');

function h = circle(x,y,r, color)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit, color);
end