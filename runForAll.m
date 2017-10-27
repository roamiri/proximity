%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           function for running PA_IL_CL2 from 1 to 16 femtocells
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function runForAll(femtocellPermutation,saveNum)

FBSSet_in = cell(1,1);
for i=1:16
    FBSSet_out = PA_IL_CL3(FBSSet_in, 32, i,femtocellPermutation,1e3, saveNum, 1);
    FBSSet_in = [];
    FBSSet_in = FBSSet_out;
end
end
