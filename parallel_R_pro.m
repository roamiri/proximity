%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Main Loop Runner in parallel:
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function parallel_R_pro(pref_poolSize)
parpool(pref_poolSize)
permutationsMat = zeros(100,16);

for i=1:100
    permutationsMat(i,:) = randperm(16,16);
end

parfor_progress(100);
 parfor i=1:100
    runForAll(permutationsMat(i,:),i);
    parfor_progress;
 end
 parfor_progress(0); % Clean up
end