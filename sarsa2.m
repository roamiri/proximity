%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Main Loop Runner in parallel:
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sarsa2(femtocellPermutation,saveNum)
actions = zeros(1,31);
% States
% states = allcomb(0:3 , 0:3); % states = (dMUE , dBS)
states = allcomb(0:1 , 0:3 , 0:3);
% Q-Table
Q = zeros(size(states,1) , size(actions , 2));
Q_ans = zeros(size(states,1) , size(actions , 2));

for i=1:16
%     Q_ans = fair_R3(mueLocation,i,NumRealization, Q);
    Q_ans = PA_RL_ref(1,i,femtocellPermutation,1e3, Q, saveNum);
    Q = Q_ans;
end
end