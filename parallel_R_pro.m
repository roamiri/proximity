%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Main Loop Runner in parallel:
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function parallel_R_pro(pref_poolSize)
% parpool(pref_poolSize)
permutationsMat = zeros(100,16);

for i=1:100
    permutationsMat(i,:) = randperm(16,16);
end
% parfor i=1:100
    fprintf('Main Loop :%d',1);
    sarsa2(permutationsMat(1,:),1);
% end
end