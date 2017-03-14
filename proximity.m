%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Main Loop Runner in parallel for proximity:
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function proximity(pref_poolSize,fbsCount,NumRealization)

parpool(pref_poolSize)
parfor i=1:fbsCount
    proximity_R3(1,i,NumRealization);
end
end