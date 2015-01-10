function [reward] = simulateReward(action, seed, data)
    
    action_track.size = data.size(action, :);
    action_track.color = data.color(action, :);
    action_track.value = data.value(action, :);
    
    %color-based user
    if strcmp(seed.color, action_track.color) == 1
        if rand<0.95
            reward = 0.1;
        else
            reward = -1;
        end
    else
        if rand<0.5
            reward = 0.1;
        else
            reward = -1;
        end
    end

end

