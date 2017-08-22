%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Main Loop Runner in parallel:
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sarsa(mueLocation,fbsCount,NumRealization)
actions = zeros(1,31);
% States
states = allcomb(0:3 , 0:3); % states = (dMUE , dBS)
% states = allcomb(0:1 , 0:3 , 0:3);
% Q-Table
Q = zeros(size(states,1) , size(actions , 2));
Q_ans = zeros(size(states,1) , size(actions , 2));
% parpool(pref_poolSize)
for i=1:fbsCount
%     Q_ans = fair_R3(mueLocation,i,NumRealization, Q);
    Q_ans = fair_Shared(i,NumRealization, Q);
    Q = Q_ans;
end
end