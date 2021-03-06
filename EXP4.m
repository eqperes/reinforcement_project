classdef EXP4<handle
    % EXP 3 strategy for one player
    
    properties
        nbActions
        w 
        advices % the advice matrix is the set of advice vectors [N x K]
        lastAction
        Gamma
    end
    
    methods
        
        function self = EXP4(nbActions,advices)
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
            matrixW = repmat(self.w, 1, K);
            p = ((1-Gamma)/W)*sum(matrixW.*advices, 1) + Gamma/K;
            action = simu(p);
            self.lastAction = action;
        end
        
        function self = getReward(self,r)
            advices = self.advices;
            Gamma = self.Gamma;
            W = sum(self.w);
            [N, K] = size(self.advices);
            matrixW = repmat(self.w, 1, K);
            p = ((1-Gamma)/W)*sum(matrixW.*advices, 1) + Gamma/K;
            
            x_hat = zeros(size(p)); 
            x_hat(self.lastAction) = r/p(self.lastAction);
            
            y_hat = advices*(x_hat'); 
            y_hat = y_hat';
            self.w = self.w.*(exp((Gamma/K)*y_hat))';
            
%             advices = (advices, lastAction, r);
        end
                
    end    
end
