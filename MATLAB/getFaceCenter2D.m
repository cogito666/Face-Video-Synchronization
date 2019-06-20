function headPos = getFaceCenter2D(data)
    % Location of a Head
    % Landmark 33 (number)
    headPosX = data(1: end, 333);
    headPosY = data(1: end, 401);
    
    headPos = [headPosX, headPosY];
end