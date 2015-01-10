function [Actions,Rewards, finalW]=TrackProblemPlay(totalTime,data)

    [K, ~] = size(data.color);
    n = 3;

    seed_number = 405;
    seed.size = data.size(seed_number,:);
    seed.color = data.color(seed_number,:);
    seed.value = data.value(seed_number,:);
    
    advices = generate_advices(seed);
    
% 	MyBandit = EXP4(K, advices);
    MyBandit = DAB(K, advices);
	MyBandit.init();
	Actions = zeros(1, totalTime);
	Rewards = zeros(1, totalTime);
	for index = 1:totalTime
		Actions(index) = MyBandit.play();
		r = simulateReward(Actions(index), seed, data);
		Rewards(index) = r;
		MyBandit.getReward(r);
    end
    
    finalW = MyBandit.w;
end