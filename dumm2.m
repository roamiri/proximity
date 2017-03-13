%
% Drawing Results for Rn1
%

c_fue = cell(1,16);
for kk =1:16
    c_fue{1,kk} = [];
end

    mue = QFinal.mue;
    FBS = QFinal.FBS;
    for j=1:size(mue,2)
        C = mue(1,j).C_profile;
        c_mue{1,j} = [ c_mue{1,j} sum(C(40000:size(C,2)))/(-40000+size(C,2))];
    end
    
    for j=1:size(FBS,2)
        C = FBS{1,j}.C_profile;
        c_fue{1,j} = [ c_fue{1,j} sum(C(40000:size(C,2)))/(-40000+size(C,2))];
    end

