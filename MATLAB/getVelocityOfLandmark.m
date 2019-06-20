function [Velocity] = getVelocityOfLandmark(MouthLandmark)
% Velocity = position_current - position_previous

    [numberOfFrames, numberOfMouthLandmark]= size(MouthLandmark);

    % 1st frame: velocity zero
    for landmarkIdx = 1 : numberOfMouthLandmark 
        Velocity{1, landmarkIdx} = [0, 0, 0];
    end
    
    % Calculate velocity
    for frameIdx = 2 : numberOfFrames
       for landmarkIdx = 1 : numberOfMouthLandmark
            Velocity{frameIdx, landmarkIdx} = MouthLandmark{frameIdx, landmarkIdx} - MouthLandmark{frameIdx-1, landmarkIdx};
       end
    end  
  
    
end

