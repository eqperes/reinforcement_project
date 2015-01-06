function [Actions,Rewards]=EXP4play(n,K,eta,Beta,Seq, advices)

	my_exp4 = EXP4(eta,Beta,K, advices);
	my_exp4.init();
	Actions = zeros(size(Seq));
	Rewards = zeros(size(Seq));
	for index = 1:size(Seq)
		Actions(index) = my_exp4.play();
		r = simulateReward(Actions(index));
		Rewards(index) = r;
		my_exp4.getReward(r);
	end
end