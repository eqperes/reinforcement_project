function [Actions,Rewards]=EXP4play(totalTime,data)

    [K, ~] = size(data.color);
    n = 3;

    seed_number = 405;
    seed.size = data.size(seed_number,:);
    seed.color = data.color(seed_number,:);
    seed.value = data.value(seed_number,:);
    
    advices = generate_advices(seed);
    
	my_exp4 = EXP4(K, advices);
	my_exp4.init();
	Actions = zeros(1, totalTime);
	Rewards = zeros(1, totalTime);
	for index = 1:totalTime
		Actions(index) = my_exp4.play();
		r = simulateReward(Actions(index), seed, data);
		Rewards(index) = r;
		my_exp4.getReward(r);
    end
    
    just = 1;
end