function landmarkMouth = getLandmarkMouth(data)

    % https://github.com/TadasBaltrusaitis/OpenFace/wiki/Output-Format
    dataSize = size(data);
    numOfFrames = dataSize(1); % Number of frames
    numOfLandmarks = 20; % Number of landmarks on Mouth
    
    % The output is cell. 
    % Each cell represent the position of each landmarks
    landmarkMouth = cell(numOfFrames, numOfLandmarks);

    % 2D facial landmark position
    % x_48 ~ x_67:(index) 348 ~ 367     
    % y_48 ~ y_67:(index) 416 ~ 435
    xStartIdx = 348;
    yStartIdx = 416;
    
    for i = 1 : numOfFrames
        for j = 1 : numOfLandmarks
            landmarkPosition = [data(i, j+(xStartIdx-1)), data(i, j+(yStartIdx-1))];
            landmarkMouth{i,j} = landmarkPosition;
        end
    end
end