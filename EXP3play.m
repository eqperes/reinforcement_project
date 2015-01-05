function [Actions,Rewards]=EXP3play(n,G,eta,Beta,Seq)

	my_exp3 = EXP3(eta,Beta,size(G,1));
	my_exp3.init();
	Actions = zeros(size(Seq));
	Rewards = zeros(size(Seq));
	for index = 1:size(Seq)
		Actions(index) = my_exp3.play();
		r = G(Actions(index), Seq(index));
		Rewards(index) = r;
		my_exp3.getReward(r);
	end
end