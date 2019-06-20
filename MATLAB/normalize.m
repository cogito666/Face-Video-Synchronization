function landmarkNormlized = normalize( mouthLandmarkPos, headPosition, headRotation)
    
    [numOfFrame, numOfLandmarks] = size(mouthLandmarkPos);
     
    % world facial landmarks
    for frameIdx = 1 : numOfFrame
       rotationMatrix = rotationVectorToMatrix(headRotation(frameIdx, :));  
       
       for landmarkIdx = 1 : numOfLandmarks         
            landmarkNormlized{frameIdx, landmarkIdx} = transpose((transpose(cell2mat(mouthLandmarkPos(frameIdx, landmarkIdx))) - transpose(headPosition(frameIdx, :))));
       end
    end  
  
    
end