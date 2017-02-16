%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Simulation of the paper:
%   A proximity-based Q-Learning Reward Function for Femtocell Networks
%
function proximity_R2(mueNumber)

%% Initialization
% clear all;
clc;
format short
format compact

%% Parameters
Pmin = -20; %dBm
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
%% Q-Learning variables
% Actions
actions = zeros(1,31);
for i=1:31
    actions(i) = -25 + (i-1) * 1.5; % dBm
end

% States
states = allcomb(0:1 , 0:3 , 0:3); % states = ( I , dMUE , dBS)

% Q-Table
Q = zeros(size(states,1) , size(actions , 2));
Q1 = ones(size(states,1) , size(actions , 2)) * inf;

alpha = 0.5; gamma = 0.9; epsilon = 0.1 ; Iterations = 50000;
%% Generate the UEs
mue(1) = UE(204, 207);
mue(2) = UE(150, 150);
mue(3) = UE(-200, 0);
selectedMUE = mue(mueNumber);
BS = BaseStation(0 , 0 , 50);

QFinal = cell(1,16);
for fbsCount=1:16
    FBS = cell(1,fbsCount);
    
    for i=1:3
        if i<= fbsCount
            FBS{i} = FemtoStation(180+(i-1)*35,150, BS, selectedMUE, 10);
        end
    end

    for i=1:3
        if i+3<= fbsCount
            FBS{i+3} = FemtoStation(150+(i-1)*35,180, BS, selectedMUE, 10);
        end
    end

    for i=1:4
        if i+6<= fbsCount
            FBS{i+6} = FemtoStation(180+(i-1)*35,215, BS, selectedMUE, 10);
        end
    end

    for i=1:3
        if i+10<= fbsCount
            FBS{i+10} = FemtoStation(150+(i-1)*35,245, BS, selectedMUE, 10);
        end
    end

    for i=1:3
        if i+13<= fbsCount
            FBS{i+13} = FemtoStation(180+(i-1)*35,280, BS, selectedMUE, 10);
        end
    end

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
    selectedMUE.SINR = SINR_MUE(FBS, BS, selectedMUE, -120, 1000);
    selectedMUE.C = log2(1+selectedMUE.SINR);

    if selectedMUE.C < gamma_th
        I = 1;
    else
        I = 0;
    end

    for j=1:size(FBS,2)
        fbs = FBS{j};
        fbs.state(1,1) = I;
        FBS{j} = fbs;
    end
    %% Main Loop
    fprintf('Loop for %d number of FBS :\t', fbsCount);
    textprogressbar(sprintf('calculating outputs:'));
    % A=[];
    % test = [16    29    10    27    22    23     7    25     5     6    14    17    21     4     2    11];
    count = 0;
    MUE_C = zeros(1,Iterations);
    xx = zeros(1,Iterations);
    errorVector = zeros(1,Iterations);
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
                    for kk = 1:32
                        if states(kk,:) == fbs.state
                            break;
                        end
                    end
                    [M, index] = max(Q(kk,:));
                    fbs = fbs.setPower(actions(index));
                    FBS{j} = fbs;
                end
            end
        else
            for j=1:size(FBS,2)
                fbs = FBS{j};
                for kk = 1:32
                    if states(kk,:) == fbs.state
                        break;
                    end
                end
                [M, index] = max(Q(kk,:));
                fbs = fbs.setPower(actions(index));
                FBS{j} = fbs;
            end
        end 

        selectedMUE.SINR = SINR_MUE_2(FBS, BS, selectedMUE, -120, 1e5);
        selectedMUE.C = log2(1+selectedMUE.SINR);
        MUE_C(1,episode) = selectedMUE.C;
        xx(1,episode) = episode;
        R = exp(-pow2(selectedMUE.C-gamma_th));%K - (selectedMUE.SINR - 20)^2;
        for j=1:size(FBS,2)
            fbs = FBS{j};
            qMax=max(Q,[],2);
            for jjj = 1:31
                if actions(1,jjj) == fbs.P
                    break;
                end
            end
            for kk = 1:32
                if states(kk,:) == fbs.state
                    break;
                end
            end
            % CALCULATING NEXT STATE
            if selectedMUE.C < gamma_th
                I = 1;
            else
                I = 0;
            end

            for nextState=1:32
                if states(nextState,:) == [I fbs.state(2:3)]
                    Q(kk,jjj) = Q(kk,jjj) + alpha*(R+gamma*qMax(nextState)-Q(kk,jjj));
                end
            end
        end

        % break if convergence: small deviation on q for 1000 consecutive
        errorVector(episode) =  sum(sum(abs(Q1-Q)));
        if sum(sum(abs(Q1-Q)))<0.01 && sum(sum(Q >0))
            if count>1000
                episode  % report last episode
                break % for
            else
                count=count+1; % set counter if deviation of q is small
            end
        else
            Q1=Q;
            count=0;  % reset counter when deviation of q from previous q is large
        end

        if selectedMUE.C < gamma_th
            I = 1;
        else
            I = 0;
        end

        for j=1:size(FBS,2) 
            fbs = FBS{j};
            fbs.state(1,1) = I;
            FBS{j} = fbs;
        end
    end
    answer.C = sum(MUE_C(0.9*Iterations:Iterations))/(0.1*Iterations);
    answer.Q = Q;
    answer.Error = errorVector;
    answer.FBS = FBS;
    QFinal{fbsCount} = answer;
end
save(sprintf('R2-MUE:%d,%d.mat',selectedMUE.X, selectedMUE.Y),'QFinal');

end
