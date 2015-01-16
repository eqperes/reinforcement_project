clear all;

s = tdfread('data.tsv');
N = 10000;

[Actions_exp4, Rewards_exp4, Weights_exp4] = TrackProblemPlay(N, s, 'exp4');
[Actions_dab, Rewards_dab, Weights_dab] = TrackProblemPlay(N, s, 'dab');

%% Observations of the evolution of weights

sumW_exp4 = sum(Weights_exp4);
sumW_dab = sum(Weights_dab);

normW_exp4 = Weights_exp4 ./ repmat(sumW_exp4, 3, 1);
normW_dab = Weights_dab ./ repmat(sumW_dab, 3, 1);

figure(1);
subplot(3,1,1);
plot(1:N, normW_exp4(1,:), 1:N, normW_dab(1,:))
subplot(3,1,2);
plot(1:N, normW_exp4(2,:), 1:N, normW_dab(2,:))
subplot(3,1,3);
plot(1:N, normW_exp4(3,:), 1:N, normW_dab(3,:))

%% Cumulative rewards

figure(2);
plot(1:N, cumsum(Rewards_exp4), 1:N, cumsum(Rewards_dab));