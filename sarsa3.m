%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Main Loop Runner in parallel:
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sarsa3(fbsCount,NumRealization)
actions = zeros(1,31);
% States
states = allcomb(0:3 , 0:3); % states = (dMUE , dBS)

% Q-Table
Q = zeros(size(states,1) , size(actions , 2));
Q_ans = zeros(size(states,1) , size(actions , 2));
% parpool(pref_poolSize)
for i=1:fbsCount
    Q_ans = R_NopunishL1_1(i,NumRealization, Q);
    Q = Q_ans;
end
end