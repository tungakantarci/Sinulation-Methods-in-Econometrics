% Exercise - Understanding consistency using simulation

%% 1. Aim of the exercise
% To understand the consistency of the OLS eatimator.

%% 2. Application

% 2.1. Clear the memory
clear;

% 2.2. Set the number of simulations 
N_sim = 1000;

% 2.3. Set the sample size
N_obs = [1000 10000 100000];
N_obs_j = size(N_obs,2);

% 2.4. Set true values for the coefficients
B_true = [0.2 0.5]';

% 2.5. Define the number of coefficients to be simulated
N_par = 1;

% 2.6. Preallocate matrices for storing the simulated statistics 
B_hat_1_sim = NaN(N_sim,N_par);
B_hat_1_sim_j = NaN(N_sim,N_obs_j);

% 2.7. Create sampling distributions for the OLS estimator 
for j = 1:N_obs_j
    for i = 1:N_sim 
        u = random('Normal',0,1,[N_obs(1,j) 1]);
        x_0 = ones(N_obs(1,j),1);
        x_1 = random('Uniform',-1,1,[N_obs(1,j) 1]);
        X = [x_0 x_1];
        y = X*B_true+u;
        LSS = exercisefunctionlss(y,X);
        B_hat_1_sim(i,1) = LSS.B_hat(2,1);
        B_hat_1_sim_j(:,j) = B_hat_1_sim(:,1);
    end
end

%% 3. Plot the sampling distributions of the OLS estimator 
ksdensity(B_hat_1_sim_j(:,1))
hold on
ksdensity(B_hat_1_sim_j(:,2))
hold on
ksdensity(B_hat_1_sim_j(:,3))
title(['Fig. 1. Sampling distribution of the OLS estimator ' ...
    'and sample size'])
legend('N\_obs = 1,000','N\_obs = 10,000','N\_obs = 100,000')
ylabel('Frequency')
xlabel('B\_hat\_1') 
