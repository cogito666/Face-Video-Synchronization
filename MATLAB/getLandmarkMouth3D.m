%% Mouth Landmark 3D
function landmarkMouth = getLandmarkMouth3D(data)

    % Number of frames
    dataSize = size(data);
    numOfFrames = dataSize(1);
    
    % Number of landmarks on Mouth
    % https://github.com/TadasBaltrusaitis/OpenFace/wiki/Output-Format
    numOfLandmarks = 20;
    
    % The output is cell. 
    % Each cell represent the position of each landmarks
    landmarkMouth = cell(numOfFrames, numOfLandmarks);

    % 3D facial landmark position
    % X_48 ~ X_67:(index) 484 ~ 503
    % Y_48 ~ Y_67:(index) 552 ~ 571
    % Z_48 ~ Z_67:(index) 620 ~ 639 
    xStartIdx = 484;
    yStartIdx = 552;
    zStartIdx = 620;
    
    for i = 1 : numOfFrames
        for j = 1 : numOfLandmarks
            landmarkPosition = [data(i, j+(xStartIdx-1)), data(i, j+(yStartIdx-1)), data(i, j+(zStartIdx-1))];
            landmarkMouth{i,j} = landmarkPosition;
        end
    end
end