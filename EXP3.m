classdef EXP3<handle
    % EXP 3 strategy for one player
    
    properties
        nbActions
        eta % learning rate
        Beta % exploration parameter
        w 
        lastAction
        Gamma
    end
    
    methods
        
        function self = EXP3(eta,Beta,nbActions)
            self.nbActions = nbActions;
            self.eta = eta;
            self.Beta = Beta;
            self.Gamma = 4*nbActions*Beta/(3+Beta);
        end
        
        function self = init(self)
            self.w = ones(1, self.nbActions);
        end
        
        function [action] = play(self)
            Gamma = self.Gamma;
            W = sum(self.w);
            p = ((1-Gamma)/W)*self.w ...
                + Gamma*(1/size(self.w, 2))* ...
                ones(1, size(self.w, 2));
            action = simu(p);
            self.lastAction = action;
        end
        
        function self = getReward(self,r)
            Gamma = self.Gamma;
            W = sum(self.w);
            p = ((1-Gamma)/W)*self.w ...
                + Gamma*(1/size(self.w, 2))* ...
                ones(1, size(self.w, 2));
            x_hat = r/p(self.lastAction) + ...
                self.Beta/p(self.lastAction);
            x_tilde = self.Beta*ones(size(self.w))./p;
            x_tilde(self.lastAction) = ...
                x_tilde(self.lastAction) + x_hat;
            self.w = self.w.*exp(self.eta*x_tilde);

        end
                
    end    
end
