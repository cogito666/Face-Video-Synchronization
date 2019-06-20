%% 3D Cost Matrix
clc;
clear;

%% Read CSV file that includes information about facial frames.
data1 = readtable('/home/cmlkaist/IITP/video3rd/normal/normal.csv', 'ReadRowNames', false);
data2 = readtable('/home/cmlkaist/IITP/video3rd/exggerated/exggerated.csv', 'ReadRowNames', false);

% Table to Matrix
video1 = table2array(data1);
video2 = table2array(data2);

%% Mouth Landmark Position 
mouthLandmarkPos1 = getLandmarkMouth3D(video1);
mouthLandmarkPos2 = getLandmarkMouth3D(video2);
 
%%  Head Position in 3-D XYZ.
headPos1 = getHeadPosition(video1);
headPos2 = getHeadPosition(video2);

%% Mouth-landmark Lelative position (Head-movement considered)
mouthLandmarkRelativePos1 = adjustMouthPosition(mouthLandmarkPos1, headPos1);
mouthLandmarkRelativePos2 = adjustMouthPosition(mouthLandmarkPos2, headPos2);

%% Movement Calculation 
% Those two videos' frames are differ. Number of landmarks are the sam    idx = idx+1;e.
sizeVideo1 = size(mouthLandmarkRelativePos1);
sizeVideo2 = size(mouthLandmarkRelativePos2);

numOfFramesVideo1 = sizeVideo1(1);
numOfFramesVideo2 = sizeVideo2(1);

% 20 landmarks for mouth.
numOfLandmark = 20;
deltaFrame = 2;

%% Sequential
% displacementVideo1 = zeros(numOfFramesVideo1-deltaFrame, 1);
% for frameIdx = 1 : numOfFramesVideo1-deltaFrame
%     displacement = 0;
%     for landmarkIdx = 1 : numOfLandmark
%        displacement = displacement + norm(mouthLandmarkRelativePos1{frameIdx, landmarkIdx}-mouthLandmarkRelativePos1{frameIdx+deltaFrame, landmarkIdx});
%     end
%     displacementVideo1(frameIdx) = displacement;
% end
% 
% displacementVideo2 = zeros(numOfFramesVideo2-deltaFrame, 1);
% for frameIdx = 1 : numOfFramesVideo2-deltaFrame
%     displacement = 0;
%     for landmarkIdx = 1 : numOfLandmark
%        displacement = displacement + norm(mouthLandmarkRelativePos2{frameIdx, landmarkIdx}-mouthLandmarkRelativePos2{frameIdx+deltaFrame, landmarkIdx});
%     end
%     displacementVideo2(frameIdx) = displacement;
% end

%% Interval
displacementVideo1 = zeros(floor(numOfFramesVideo1/deltaFrame), 1);
frameIdx = 1;
idx = 1;
while frameIdx+deltaFrame < floor(numOfFramesVideo1/deltaFrame)
    displacement = 0;
    for landmarkIdx = 1 : numOfLandmark
       displacement = displacement + norm(mouthLandmarkRelativePos1{frameIdx, landmarkIdx}-mouthLandmarkRelativePos1{frameIdx+deltaFrame, landmarkIdx});
    end
    displacementVideo1(idx) = displacement;
    
    idx = idx+1;
    frameIdx = frameIdx + deltaFrame;
end

displacementVideo2 = zeros(floor(numOfFramesVideo2/deltaFrame), 1);
frameIdx = 1;
idx = 1;
while frameIdx+deltaFrame < floor(numOfFramesVideo2/deltaFrame)
    displacement = 0;
    for landmarkIdx = 1 : numOfLandmark
       displacement = displacement + norm(mouthLandmarkRelativePos2{frameIdx, landmarkIdx}-mouthLandmarkRelativePos2{frameIdx+deltaFrame, landmarkIdx});
    end
    displacementVideo2(frameIdx) = displacement;
    
    idx = idx+1;
    frameIdx = frameIdx + deltaFrame;
end

%% Cost-Matrix
len1 = length(displacementVideo1);
len2 = length(displacementVideo2);

CostMatrix = zeros(len1, len2);
for idxVideo1 = 1 : len1
    for idxVideo2 = 1 : len2
        
        CostMatrix(idxVideo1, idxVideo2) = abs(displacementVideo1(idxVideo1)-displacementVideo2(idxVideo2));
        
    end
end
%%
colormap(flipud(gray))
imagesc(CostMatrix)
colorbar
