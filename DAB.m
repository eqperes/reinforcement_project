classdef DAB<handle
    % EXP 3 strategy for one player
    
    properties
        nbActions
        w 
        advices % the advice matrix is the set of advice vectors [N x K]
        lastAction
        Gamma
    end
    
    methods
        
        function self = DAB(nbActions,advices)
            self.nbActions = nbActions;
            self.Gamma = 0.1;
            self.advices = advices;
        end
        
        function self = init(self)
            [n, ~] = size(self.advices);
            self.w = ones(n, 1);
        end
        
        function [action] = play(self)
            advices = self.advices;
            Gamma = self.Gamma;
            W = sum(self.w);
            [N, K] = size(self.advices);
            self.w;
            p = ((1-Gamma)/W)*self.w + Gamma/N;
            arm = simu(p);
            action = simu(advices(arm,:));
            self.lastAction = action;
        end
        
        function self = getReward(self,r)
            advices = self.advices;
            Gamma = self.Gamma;
            W = sum(self.w);
            [N, K] = size(self.advices);
            p = ((1-Gamma)/W)*self.w + Gamma/N;
            
            x_hat = zeros( size(advices(1,:))); 
            bigP = p'*advices(:, self.lastAction);
            x_hat(self.lastAction) = r/bigP;
            
            y_hat = advices*(x_hat'); 
            y_hat = y_hat';
            self.w = self.w.*(exp((Gamma/K)*y_hat))';
            
%             advices = (advices, lastAction, r);
        end
                
    end    
end
