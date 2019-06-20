function headRot = getHeadRotation(data)
    % Location of a Head
    % pose_Rx, pose_Ry, pose_Rz
    headRotX = data(1: end, 297);
    headRotY = data(1: end, 298);
    headRotZ = data(1: end, 299);
    
    headRot = [headRotX, headRotY, headRotZ];
end