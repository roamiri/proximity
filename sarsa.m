%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Main Loop Runner in parallel:
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sarsa(pref_poolSize,fbsCount,NumRealization)

% c = parcluster;
% % poolobj = gcp('nocreate'); % If no pool, do not create new one.
% if isempty(c)
%     poolsize = 0;
% else
%     poolsize = c.NumWorkers;
% end
% if poolsize>pref_poolSize
%     c.NumWorkers=pref_poolSize;
% end

parpool(pref_poolSize)
parfor i=1:fbsCount
    fair(i,NumRealization);
end
end