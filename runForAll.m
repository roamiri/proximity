%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           function for running PA_IL_CL2 from 1 to 16 femtocells
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function runForAll(femtocellPermutation,saveNum)

FBSSet = cell(1,1);
for i=1:16
    FBSSet = PA_IL_CL2(FBSSet, i,femtocellPermutation,1e3, saveNum);
end
end
