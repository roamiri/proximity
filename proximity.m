%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Simulation of the paper:
%   A proximity-based Q-Learning Reward Function for Femtocell Networks
%
%% Initialization
clear;
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
mue1 = UE(-200, 0);
mue2 = UE(204, 207);
mue3 = UE(150, 150);
selectedMUE = mue3;
BS = BaseStation(0 , 0 , 50);
FBS = cell(1,16);
for i=1:3
    FBS{i} = FemtoStation(180+(i-1)*35,150, BS, selectedMUE, 10);
end

for i=1:3
    FBS{i+3} = FemtoStation(150+(i-1)*35,180, BS, selectedMUE, 10);
end

for i=1:4
    FBS{i+6} = FemtoStation(180+(i-1)*35,215, BS, selectedMUE, 10);
end

for i=1:3
    FBS{i+10} = FemtoStation(150+(i-1)*35,245, BS, selectedMUE, 10);
end

for i=1:3
    FBS{i+13} = FemtoStation(180+(i-1)*35,280, BS, selectedMUE, 10);
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
textprogressbar('calculating outputs: ');
% A=[];
% test = [16    29    10    27    22    23     7    25     5     6    14    17    21     4     2    11];
% count = 0;
MUE_C = zeros(1,Iterations);
xx = zeros(1,Iterations);
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
 
    selectedMUE.SINR = SINR_MUE(FBS, BS, selectedMUE, -120, 1000);
    selectedMUE.C = log2(1+selectedMUE.SINR);
    MUE_C(1,episode) = selectedMUE.C;
    xx(1,episode) = episode;
    R = K - (selectedMUE.SINR - 20)^2;
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

%% Generate Reward Matrix
% Reward = zeros(size(states,1), size(actions,2));
% for j=1:size(FBS,2)
%     fbs = FBS{j};
%     for i=1:size(actions,2)
%         fbs = fbs.setPower(actions(i));
%         mue1.SINR = SINR_MUE(FBS, BS, mue1, -120);
%         mue1.C = log2(1+mue1.SINR);
%         fbs = fbs.getDistanceStatus;
%         if mue1.C >= gamma_th
%             fbs.state(1) = 0;
%         else
%             fbs.state(1) = 1;
%         end
%         for kk = 1:32
%             if states(kk,:) == fbs.state
%                 Reward(kk,i) = K - (mue1.SINR - 2)^2;
%                 break;
%             end
%         end
%     end
%     FBS{j} = fbs;
% end
% %% Main Loop
% for episode = 1:Iterations
%     % random initial state
%     y=randperm(size(R,1));
%     state=y(1); % current state
%     
% %     while state~=goalState            % loop until find goal state
%         % select any action from this state
%         x=find(R(state,:)>=0);         % find possible action of this state
%         if size(x,1)>0,
%             x1=RandomPermutation(x);   % randomize the possible action
%             x1=x1(1);                  % select an action (only the first element of random sequence)
%         end
% 
%         qMax=max(q,[],2);
%         q(state,x1)= R(state,x1)+gamma*qMax(x1);     % get max of all actions from the next state for Q of current state
%         state=x1;
% %     end 
% end




