classdef EXP4<handle
    % EXP 3 strategy for one player
    
    properties
        nbActions
        eta % learning rate
        Beta % exploration parameter
        w 
        advices % the advice matrix is the set of advice vectors [N x K]
        lastAction
        Gamma
    end
    
    methods
        
        function self = EXP3(eta,Beta,nbActions,advices)
            self.nbActions = nbActions;
            self.eta = eta;
            self.Beta = Beta;
            self.Gamma = 4*nbActions*Beta/(3+Beta);
            self.advices = advices;
        end
        
        function self = init(self)
            self.w = ones(1, self.nbActions);
        end
        
        function [action] = play(self)
            Gamma = self.Gamma;
            W = sum(self.w);
            [N, K] = size(self.advices);
            matrixW = repmat(self.w, 1, K);
            p = ((1-Gamma)/W)*sum(matrixW.*advices, 1) + Gamma/K;
            action = simu(p);
            self.lastAction = action;
        end
        
        function self = getReward(self,r)
            Gamma = self.Gamma;
            W = sum(self.w);
            [N, K] = size(self.advices);
            matrixW = repmat(self.w, 1, K);
            p = ((1-Gamma)/W)*sum(matrixW.*advices, 1) + Gamma/K;
            
            x_hat = ones(size(p)); 
            x_hat(self.lastAction) = r/p(self.lastAction);
            
            y_hat = advices*(x_hat'); y_hat = y_hat';
            self.w = self.w.*exp((Gamma/K)*y_hat);
            
            actualizeAdvices = (advices, lastAction, r);
        end
                
    end    
end