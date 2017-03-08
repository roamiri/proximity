%
% Drawing Results for Rn1
%
% clear all;
% clear;
% dirName = 'Results/1000,Rn1withoutBeta';
% listing=dir(dirName);

% p_mue(1) = figure;
% p_mue(2) = figure;
% p_mue(3)= figure;

c_mue = cell(1,3);
c_mue{1,1} = [];
c_mue{1,2} = [];
c_mue{1,3} = [];

c_fue = cell(1,16);
for kk =1:16
    c_fue{1,kk} = [];
end

% p_fue(1) = figure;
% p_fue(2) = figure;
% p_fue(3)= figure;

% for i=3:size(listing,1)
%     filename = strcat(dirName , '/', listing(i).name);
%     load(filename);
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
% end

% %%
% for j=1:size(mue,2)
%     figure(p_mue(j));
%     plot(c_mue{1,j});
%     hold on;
%     plot( ones(1,16)*3.76, '--k' )
% end
% %%
% figure(p_fue(1));
% plot(c_fue{1,1});
% hold on;
% plot( ones(1,16)*12.50, '--k' )
% %%
% figure(p_fue(2));
% plot(c_fue{1,4});
% hold on;
% plot( ones(1,16)*12.50, '--k' )
% %%
% figure(p_fue(3));
% plot(c_fue{1,8});
% hold on;
% plot( ones(1,16)*12.50, '--k' )
