%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Main Loop Runner in parallel for proximity:
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function proximity(pref_poolSize,fbsCount,NumRealization)

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
    proximity_R3(3,i,NumRealization);
end
end