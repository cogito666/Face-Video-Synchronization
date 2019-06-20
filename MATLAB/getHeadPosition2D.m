function headPos = getHeadPosition2D(data)
    % Location of a Head
    % pose_Tx, pose_Ty, pose_Tz
    headPosX = data(1: end, 294);
    headPosY = data(1: end, 295);
    
    headPos = [headPosX, headPosY];
end