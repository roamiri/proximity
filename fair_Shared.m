%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Simulation of Rn1:
%   
%
function Q = fair_Shared(fbsCount, NumRealization, QTable)

%% Initialization
% clear all;
clc;
format short
format compact

%% Parameters
Pmin = -20;                                                                                                                                                                                                                                                                                                                                                                           %dBm
Pmax = 25; %dBm
Npower = 31;

dth = 25;
Kp = 100; % penalty constant for MUE capacity threshold
Gmue = 1.37; % bps/Hz
StepSize = 1.5; % dBm
K = 1000;
PBS = 50 ; %dBm
sinr_th = 1.64;%10^(2/10); % I am not sure if it is 2 or 20!!!!!
gamma_th = log2(1+sinr_th);
%% Minimum Rate Requirements for N MUE users
N = 3;
q_N = 1.4005; q_M=1.25;
%% Q-Learning variables
% Actions
actions = zeros(1,31);
for i=1:31
    actions(i) = Pmin + (i-1) * 1.5; % dBm
end

% States
states = allcomb(0:3 , 0:3); % states = (dMUE , dBS)

% Q-Table
% Q = zeros(size(states,1) , size(actions , 2));
Q1 = ones(size(states,1) , size(actions , 2)) * inf;

alpha = 0.5; gamma = 0.9; epsilon = 0.1 ; Iterations = 50000;
%% Generate the UEs
mue(1) = UE(204, 207);
% mue(2) = UE(150, 150);
% mue(1) = UE(-200, 0);
% selectedMUE = mue(mueNumber);
BS = BaseStation(0 , 0 , 50);
%%
%Generate fbsCount=16 FBSs
FBS_Max = cell(1,16);
for i=1:3
%     if i<= fbsCount
        FBS_Max{i} = FemtoStation(180+(i-1)*35,150, BS, mue, 10);
%     end
end

for i=1:3
%     if i+3<= fbsCount
        FBS_Max{i+3} = FemtoStation(165+(i-1)*30,180, BS, mue, 10);
%     end
end

for i=1:4
%     if i+6<= fbsCount
        FBS_Max{i+6} = FemtoStation(150+(i-1)*35,200, BS, mue, 10);
%     end
end

for i=1:3
%     if i+10<= fbsCount
        FBS_Max{i+10} = FemtoStation(160+(i-1)*35,240, BS, mue, 10);
%     end
end

for i=1:3
%     if i+13<= fbsCount
        FBS_Max{i+13} = FemtoStation(150+(i-1)*35,280, BS, mue, 10);
%     end
end
%%
% 
FBS = cell(1,fbsCount);

if fbsCount>=1, FBS{1} = FBS_Max{1}; end
if fbsCount>=2, FBS{2} = FBS_Max{3}; end
if fbsCount>=3, FBS{3} = FBS_Max{14}; end
if fbsCount>=4, FBS{4} = FBS_Max{16}; end
if fbsCount>=5, FBS{5} = FBS_Max{9}; end
if fbsCount>=6, FBS{6} = FBS_Max{4}; end
if fbsCount>=7, FBS{7} = FBS_Max{2}; end
if fbsCount>=8, FBS{8} = FBS_Max{15}; end
if fbsCount>=9, FBS{9} = FBS_Max{10}; end
if fbsCount>=10, FBS{10} = FBS_Max{12}; end
if fbsCount>=11, FBS{11} = FBS_Max{5}; end
if fbsCount>=12, FBS{12} = FBS_Max{7}; end
if fbsCount>=13, FBS{13} = FBS_Max{11}; end
if fbsCount>=14, FBS{14} = FBS_Max{6}; end
if fbsCount>=15, FBS{15} = FBS_Max{8}; end
if fbsCount>=16, FBS{16} = FBS_Max{13}; end

    %% Initialization and find MUE Capacity
    % permutedPowers = npermutek(actions,3);
    permutedPowers = randperm(size(actions,2),size(FBS,2));
    % y=randperm(size(permutedPowers,1));
    for j=1:size(FBS,2)
        fbs = FBS{j};
        fbs = fbs.setPower(actions(permutedPowers(j)));
        fbs = fbs.getDistanceStatus;
        FBS{j} = fbs;
    end
%     selectedMUE.SINR = SINR_MUE(FBS, BS, selectedMUE, -120, 1000);
%     selectedMUE.C = log2(1+selectedMUE.SINR);

%     if selectedMUE.C < gamma_th
%         I = 1;
%     else
%         I = 0;
%     end
% 
%     for j=1:size(FBS,2)
%         fbs = FBS{j};
%         fbs.state(1,1) = I;
%         FBS{j} = fbs;
%     end
    %% Main Loop
    fprintf('Loop for %d number of FBS :\t', fbsCount);
    textprogressbar(sprintf('calculating outputs:'));
    count = 0;
    MUE_C = zeros(1,Iterations);
    xx = zeros(1,Iterations);
    errorVector = zeros(1,Iterations);
    % K1 is distance of selectedMUE from Agents
%     k1 = zeros(1,size(FBS,2));
    dth = 25; %meter
%     Kp = 100;
%     for i=1:size(FBS,2)
%         k1(i) = (sqrt((FBS{i}.X-selectedMUE.X)^2+(FBS{i}.Y-selectedMUE.Y)^2))/dth;
%     end
    for episode = 1:Iterations
        textprogressbar((episode/Iterations)*100);
        permutedPowers = randperm(size(actions,2),size(FBS,2));
        if (episode/Iterations)*100 < 80
            % Action selection with epsilon=0.1
            if rand<epsilon
                for j=1:size(FBS,2)
                    fbs = FBS{j};
                    fbs = fbs.setPower(actions(permutedPowers(j)));
                    FBS{j} = fbs;
                end
            else
                for j=1:size(FBS,2)
                    fbs = FBS{j};
                    for kk = 1:size(states,1)
                        if states(kk,:) == fbs.state
                            break;
                        end
                    end
                    [M, index] = max(QTable(kk,:));
                    fbs = fbs.setPower(actions(index));
                    FBS{j} = fbs;
                end
            end
        else
            for j=1:size(FBS,2)
                fbs = FBS{j};
                for kk = 1:size(states,1)
                    if states(kk,:) == fbs.state
                        break;
                    end
                end
                [M, index] = max(QTable(kk,:));
                fbs = fbs.setPower(actions(index));
                FBS{j} = fbs;
            end
        end 

        % calc FUEs and MUEs capacity
        SINR_FUE_Vec = SINR_FUE(FBS, BS, -120, NumRealization);
        C_FUE_Vec = log2(1+SINR_FUE_Vec);
        for i=1:size(mue,2)
            MUE = mue(i);
            MUE.SINR = SINR_MUE_2(FBS, BS, MUE, -120, NumRealization);
            MUE = MUE.setCapacity(log2(1+MUE.SINR));
            mue(i)=MUE;
        end
        
%         MUE_C(1,episode) = selectedMUE.C;
        xx(1,episode) = episode;
%         R = K - (selectedMUE.SINR - sinr_th)^2;
%             deviation_FUE=0.0;
%             for i=1:size(FBS,2)
%                 deviation_FUE = deviation_FUE + (fbs.C_FUE-q_M)^2;
%             end
        dum1 = 1.0;
        for i=1:size(mue,2)
            dum1 = dum1 * (mue(i).C-q_N)^2;
        end
        dum2 = 1.0;
        for j=1:size(FBS,2)
            fbs = FBS{j};
            fbs = fbs.setCapacity(log2(1+SINR_FUE_Vec(j)));
            dum2 = dum2 * (fbs.C_FUE-q_M)^2;
            FBS{j}=fbs;
        end
        
%         R = K - dum2*dum1;
        for j=1:size(FBS,2)
            fbs = FBS{j};
            qMax=max(QTable,[],2);
            for jjj = 1:31
                if actions(1,jjj) == fbs.P
                    break;
                end
            end
            for kk = 1:size(states,1)
                if states(kk,:) == fbs.state
                    break;
                end
            end
            % CALCULATING NEXT STATE AND REWARD
            beta = fbs.dMUE/dth;
            R = beta*fbs.C_FUE - (1/beta)*dum1*dum2;
            for nextState=1:size(states,1)
                if states(nextState,:) == fbs.state
                    QTable(kk,jjj) = QTable(kk,jjj) + alpha*(R+gamma*qMax(nextState)-QTable(kk,jjj));
                end
            end
            FBS{j}=fbs;
        end

        % break if convergence: small deviation on q for 1000 consecutive
        errorVector(episode) =  sum(sum(abs(Q1-QTable)));
        if sum(sum(abs(Q1-QTable)))<1 && sum(sum(QTable >0))
            if count>1000
                episode  % report last episode
                break % for
            else
                count=count+1; % set counter if deviation of q is small
            end
        else
            Q1=QTable;
            count=0;  % reset counter when deviation of q from previous q is large
        end

%         if selectedMUE.C < gamma_th
%             I = 1;
%         else
%             I = 0;
%         end
% 
%         for j=1:size(FBS,2) 
%             fbs = FBS{j};
%             fbs.state(1,1) = I;
%             FBS{j} = fbs;
%         end
    end
    Q = QTable;
    answer.mue = mue;
    answer.Q = QTable;
    answer.Error = errorVector;
    answer.FBS = FBS;
    min_CFUE = inf;
    for j=1:size(FBS,2)
        C = FBS{1,j}.C_profile;
        c_fue(1,j) = sum(C(40000:size(C,2)))/(-40000+size(C,2));
        if min_CFUE > c_fue(1,j)
            min_CFUE = c_fue(1,j);
        end
    end
    sum_CFUE = 0.0;
    for i=1:size(FBS,2)
        sum_CFUE = sum_CFUE + c_fue(1,i);
    end
    answer.C_FUE = c_fue;
    answer.sum_CFUE = sum_CFUE;
    answer.min_CFUE = min_CFUE;
    QFinal = answer;
    save(sprintf('fairResults/R_share_beta2:%d,Real:%d.mat',fbsCount, NumRealization),'QFinal');

end




