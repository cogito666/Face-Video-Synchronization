function headPos = getHeadPosition(data)
    % Location of a Head
    % pose_Tx, pose_Ty, pose_Tz
    headPosX = data(: , 294);
    headPosY = data(: , 295);
    headPosZ = data(: , 296);
    
    headPos = [headPosX, headPosY, headPosZ];
end