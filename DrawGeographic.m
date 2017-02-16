%%
figure;
hold on;

dM1 = 15; dM2 = 50; dM3 = 125; 
dB1 = 50; dB2 = 150; dB3 = 400;

for i=1:16
    fbs = FBS{i};
    p = plot(fbs.X, fbs.Y);
    p.Marker = '*';
    ss = size(fbs.powerProfile,2);
    txt1 = sprintf('%.1f',fbs.powerProfile(ss-10));
    text(fbs.X, fbs.Y-5,txt1)    
end
axis([-300,300,-50,300]);

p = plot(BS.X, BS.Y);
p.Marker = 'diamond';
circle(BS.X,BS.Y,dB1);
circle(BS.X,BS.Y,dB2);
circle(BS.X,BS.Y,dB3);

p = plot(selectedMUE.X, selectedMUE.Y);
p.Marker = 'square';
circle(selectedMUE.X,selectedMUE.Y,dM1);
circle(selectedMUE.X,selectedMUE.Y,dM2);
circle(selectedMUE.X,selectedMUE.Y,dM3);

function h = circle(x,y,r)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit);
end