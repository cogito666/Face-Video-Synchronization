function result = distanceBetweenFrames3D (landmark1, landmark2)
    
    % Number of mouth landmark
    numOfMouthLandmark = 20;
    
    cost = 0;
    for landmarkIdx = 1 : numOfMouthLandmark
        cost= cost + norm(landmark1())
    end
    result = cost;
end