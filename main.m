%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Main Loop Runner in parallel:
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function main(parallel, pref_poolSize)

permutationsMat = zeros(100,16);
for i=1:100
    permutationsMat(i,:) = randperm(16,16);
end

if parallel
    parpool(pref_poolSize)
    parfor_progress(100);
    for i=1:100
        runForAll(permutationsMat(i,:),i);
        pause(rand);
        parfor_progress;
    end
    parfor_progress(0); % Clean up
else
    runForAll(permutationsMat(i,:),i);
end
