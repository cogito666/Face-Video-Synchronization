function mouthLandmarkRelativePosition = adjustMouthPosition2D( mouthLandmarkPos, faceCenter)

    % Facial Center as Head Position 
    % On paper it's choosing arbitrary one. I choose first frame.
    refHeadPosX = faceCenter(1,1);
    refHeadPosY = faceCenter(1,2);
    
    [numOfFrame, numOfLandmarks] = size(mouthLandmarkPos);
    mouthLandmarkRelativePosition = cell(numOfFrame, numOfLandmarks);
    
    % Adjust Head-Pos Displacement
    % Displacement of Head-Position is same for landmakrs of a frame.
    for frameIdx = 1 : numOfFrame
       dispX = faceCenter(frameIdx, 1)-refHeadPosX;
       dispY = faceCenter(frameIdx, 2)-refHeadPosY;
       
       for landmarkIdx = 1 : numOfLandmarks
           rawPosition = mouthLandmarkPos{frameIdx, landmarkIdx};
           mouthLandmarkRelativePosition{frameIdx, landmarkIdx} = rawPosition - [dispX dispY];
       end
    end
       
end