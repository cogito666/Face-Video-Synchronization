function result = distanceBetweenFrames (xpos, ypos)
    [numOfFrames, numOfLandmarks] = size(xpos);
    result = zeros(numOfFrames-1,1);

    for frameIntervalIdx = 1 : numOfFrames - 1 
        cost = 0;
        for landmarkIdx = 1:numOfLandmarks
            currentLandmarkPos = [xpos(frameIntervalIdx,landmarkIdx), ypos(frameIntervalIdx,landmarkIdx)];
            nextLandmarkPos = [xpos(frameIntervalIdx+1,landmarkIdx), ypos(frameIntervalIdx+1,landmarkIdx)];

            cost= cost + Euclidean2D(currentLandmarkPos(1), currentLandmarkPos(2), nextLandmarkPos(1), nextLandmarkPos(2));
        end
        result(frameIntervalIdx)= cost;
    end
end