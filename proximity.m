%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Main Loop Runner in for proximity:
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function proximity(mueLocation,fbsCount,NumRealization)

actions = zeros(1,31);
% States
states = allcomb(0:1 , 0:3 , 0:3);

% Q-Table
Q = zeros(size(states,1) , size(actions , 2));
Q_ans = zeros(size(states,1) , size(actions , 2));

for i=1:fbsCount
    Q_ans = fair_R3(mueLocation,i,NumRealization, Q);
    Q = Q_ans;
end
end
