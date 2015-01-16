function [Actions,Rewards, weights]=TrackProblemPlay(totalTime,data, algo)

    [K, ~] = size(data.color);
    n = 3;

    seed_number = 405;
    seed.size = data.size(seed_number,:);
    seed.color = data.color(seed_number,:);
    seed.value = data.value(seed_number,:);
    
    advices = generate_advices(seed);
    
    if (strcmp(algo, 'exp4'))
        MyBandit = EXP4(K, advices);
    else
        MyBandit = DAB(K, advices);
    end;
    
	MyBandit.init();
    
	Actions = zeros(1, totalTime);
	Rewards = zeros(1, totalTime);
    weights = zeros(n, totalTime);
    
	for index = 1:totalTime
		Actions(index) = MyBandit.play();
		r = simulateReward(Actions(index), seed, data);
		Rewards(index) = r;
        weights(:, index) = MyBandit.w;
		MyBandit.getReward(r);
    end
    
end