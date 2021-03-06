%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Simulation of Rn1:
%   
%
function upperBound(fbsCount, NumRealization)

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
Q = zeros(size(states,1) , size(actions , 2));
Q1 = ones(size(states,1) , size(actions , 2)) * inf;

alpha = 0.5; gamma = 0.9; epsilon = 0.1 ; Iterations = 50000;
%% Generate the UEs
mue(1) = UE(204, 207);
% mue(2) = UE(150, 150);
% mue(1) = UE(-200, 0);
% selectedMUE = mue(mueNumber);
BS = BaseStation(0 , 0 , 50);

% QFinal = cell(1,16);
% for fbsCount=1:16
    FBS = cell(1,fbsCount);
    
    for i=1:3
        if i<= fbsCount
            FBS{i} = FemtoStation(180+(i-1)*35,150, BS, mue, 10);
        end
    end

    for i=1:3
        if i+3<= fbsCount
            FBS{i+3} = FemtoStation(150+(i-1)*35,180, BS, mue, 10);
        end
    end

    for i=1:4
        if i+6<= fbsCount
            FBS{i+6} = FemtoStation(180+(i-1)*35,215, BS, mue, 10);
        end
    end

    for i=1:3
        if i+10<= fbsCount
            FBS{i+10} = FemtoStation(150+(i-1)*35,245, BS, mue, 10);
        end
    end

    for i=1:3
        if i+13<= fbsCount
            FBS{i+13} = FemtoStation(180+(i-1)*35,280, BS, mue, 10);
        end
    end

    for i=1:3
        if i+16<= fbsCount
            FBS{i+16} = FemtoStation(180+(i-1)*35,350, BS, mue, 10);
        end
    end
    %% Initialization and find MUE Capacity
    % permutedPowers = npermutek(actions,3);
    permutedPowers = randperm(size(actions,2),size(FBS,2));
    % y=randperm(size(permutedPowers,1));
    for j=1:size(FBS,2)
        fbs = FBS{j};
        fbs = fbs.setPower(actions(1));
        fbs = fbs.getDistanceStatus;
        FBS{j} = fbs;
    end
    SINR_FUE_Vec = SINR_FUE(FBS, BS, -120, NumRealization);
    C_FUE_Vec = log2(1+SINR_FUE_Vec);
    for i=1:size(mue,2)
        MUE = mue(i);
        MUE.SINR = SINR_MUE_2(FBS, BS, MUE, -120, NumRealization);
        MUE = MUE.setCapacity(log2(1+MUE.SINR));
        mue(i)=MUE;
    end
    for j=1:size(FBS,2)
        fbs = FBS{j};
        fbs = fbs.setCapacity(log2(1+SINR_FUE_Vec(j)));
        FBS{j}=fbs;
    end
    
    answer.mue = mue;
    answer.FBS = FBS;
    min_CFUE = inf;
    for j=1:size(FBS,2)
        c_fue(1,j) = FBS{1,j}.C_profile;
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
    save(sprintf('Compare/upperBound:%d,Real:%d.mat',fbsCount, NumRealization),'QFinal');

end




