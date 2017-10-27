
clear;
clc;
%%
s = sprintf('oct10/FUE_R_18_time.mat');
filename = strcat(s);
load(filename);

s = sprintf('oct10/FUE_Rref_noshare.mat');
filename = strcat(s);
load(filename);

%%
figure;
hold on;
grid on;
box on;

fariness = zeros(1,16);
fariness_ref = zeros(1,16);
for i=1:16
vec = C_FUE_Mat{i};
vec_ref = C_FUE_Mat_ref{i};
num = 0.0;
num_ref = 0.0;
denom = 0.0;
denom_ref = 0.0;
n = size(vec,2);
for j=1:n
    num = num + vec(j);
    num_ref = num_ref + vec_ref(j);
    denom = denom + vec(j)^2;
    denom_ref = denom_ref + vec_ref(j)^2;
end
    fariness(i) = (num^2)/(n*denom);
    fairness_ref(i) = (num_ref^2)/(n*denom_ref);
end
plot(fariness, 'r--.', 'LineWidth',1,'MarkerSize',10);
% plot(fairness_ref, 'b--.', 'LineWidth',1,'MarkerSize',10);
xlim([2 15]);
ylim([0 1.05]);
title('Fairness index','FontSize',14, 'FontWeight','bold');
xlabel('FBS Numbers','FontSize',14, 'FontWeight','bold');
ylabel('Jains Index For Fairness','FontSize',14, 'FontWeight','bold');
