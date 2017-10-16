%%
mue(1) = UE(204, 207);
fbsCount = 16;
FBS = cell(1,fbsCount);
BS = BaseStation(0 , 0 , 50);    
    for i=1:3
        if i<= fbsCount
            FBS{i} = FemtoStation(180+(i-1)*35,150, BS, mue, 10);
        end
    end

    for i=1:3
        if i+3<= fbsCount
            FBS{i+3} = FemtoStation(165+(i-1)*30,180, BS, mue, 10);
        end
    end

    for i=1:4
        if i+6<= fbsCount
            FBS{i+6} = FemtoStation(150+(i-1)*35,200, BS, mue, 10);
        end
    end

    for i=1:3
        if i+10<= fbsCount
            FBS{i+10} = FemtoStation(160+(i-1)*35,240, BS, mue, 10);
        end
    end

    for i=1:3
        if i+13<= fbsCount
            FBS{i+13} = FemtoStation(150+(i-1)*35,280, BS, mue, 10);
        end
    end
%%
figure;
hold on;
grid on;

dM1 = 15; dM2 = 50; dM3 = 125; 
% dM1 = 30; dM2 = 50; dM3 = 80;
dB1 = 50; dB2 = 150; dB3 = 400;
% dB1 = 250; dB2 = 300; dB3 = 350;
BS = BaseStation(0 , 0 , 50);
% FBS = QFinal.FBS;
fbs = FBS{1};
p1 = plot(fbs.X, fbs.Y, 'r');
p1.Marker = '*';
p2 = plot(fbs.X, fbs.Y+10, 'k');
p2.Marker = 'x';
for i=2:16
    fbs = FBS{i};
    p = plot(fbs.X, fbs.Y, 'r','LineWidth',0.75,'MarkerSize',8);
    p.Marker = '*';
    p = plot(fbs.X, fbs.Y+10, 'k','LineWidth',0.75,'MarkerSize',8);
    p.Marker = 'x';
    
%     ss = size(fbs.powerProfile,2);
%     txt1 = sprintf('%.1f',fbs.powerProfile(ss-10));
%     text(fbs.X, fbs.Y-5,txt1)    
end
axis([-300,350,-100,350]);

p3 = plot(BS.X, BS.Y, 'b','LineWidth',1,'MarkerSize',8);
p3.Marker = 'diamond';
circle(BS.X,BS.Y,dB1, 'b');
circle(BS.X,BS.Y,dB2, 'b');
circle(BS.X,BS.Y,dB3, 'b');
% selectedMUE = QFinal.mue;
selectedMUE.X = 204;
selectedMUE.Y = 207;
p4 = plot(selectedMUE.X, selectedMUE.Y, 'k','LineWidth',1,'MarkerSize',8);
% p1 = plot(150, 150, 'k');
% p5 = plot(-200, 0, 'k');
% p5.Marker = 'square';
% p1.Marker = 'square';
p4.Marker = 'square';
circle(selectedMUE.X,selectedMUE.Y,dM1, 'r');
circle(selectedMUE.X,selectedMUE.Y,dM2, 'r');
circle(selectedMUE.X,selectedMUE.Y,dM3, 'r');

title('System Model','FontSize',14, 'FontWeight','bold');
xlabel('x position','FontSize',14, 'FontWeight','bold');
ylabel('y position','FontSize',14, 'FontWeight','bold');
legend([p3 p1 p2 p4],{'BS','FBS', 'FUE', 'MUE'});
box on;
set(gca,'fontsize',14, 'FontWeight','bold');
% pbaspect([1 1 1])
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

% ht = text(-230, 270, {'{\color{blue} d } BS', '{\color{red} * } FBS', '{\color{black} x } FUE' , '{\color{black} s } MUE'}, 'EdgeColor', 'k');
% ht = text(-230, 270, {'{\color{blue} d } BS', '{\color{red} * } FBS','{\color{black} s } MUE'}, 'EdgeColor', 'k');

function h = circle(x,y,r, color)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit, color,'LineWidth',1.5,'MarkerSize',10);
end