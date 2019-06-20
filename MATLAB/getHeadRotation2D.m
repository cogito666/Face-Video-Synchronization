function headRot = getHeadRotation2D(data)
    % Location of a Head
    % pose_Rx, pose_Ry, pose_Rz
    headRotX = data(1: end, 297);
    headRotY = data(1: end, 298);
    
    headRot = [headRotX, headRotY];
end