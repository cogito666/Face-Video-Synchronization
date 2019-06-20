%% 3D Cost Matrix
clc;
clear all;

%% Read CSV file that includes information about facial frames.
data1 = readtable('/home/cmlkaist/IITP/video3rd/result/normal.csv', 'ReadRowNames', false);
% data2 = readtable('/home/cmlkaist/IITP/video2nd/result/Speech2-2.csv', 'ReadRowNames', false);

% Table to Matrix
video1 = table2array(data1);
% video2 = table2array(data2);

%% Mouth Landmark Position 
mouthLandmark3DPosVideo1 = getLandmarkMouth3D(video1);
% mouthLandmark3DPosVideo2 = getLandmarkMouth3D(video2);

mouthLandmark2DPosVideo1 = getLandmarkMouth2D(video1);
% mouthLandmark2DPosVideo2 = getLandmarkMouth2D(video2);

%% Projection 3D Worold to 2D-Image
cx = 640;
cy = 360;
fx = 720;
fy = 720;

%% Get Projection on 2D plane.
cameraMatrix = 316.7672*[fx 0 cx;...
                         0 fy cy;...
                         0 0 1];




%% Plot 3-D Mouth Landmarks
[numOfFrames, numOfLandmarks] = size(mouthLandmarkPos1);

clf;
figure(1);
grid on;
axis equal;

dt = 0.2;

for frameIdx = 1 : numOfFrames
    for landmarkIdx = 1 : numOfLandmarks
        currentPoint = mouthLandmarkPos1{frameIdx, landmarkIdx};
        plot3(currentPoint(1, 1), currentPoint(1, 2), -currentPoint(1, 3), '-og', 'LineWidth', 2);
        text(currentPoint(1, 1)+dt, currentPoint(1, 2)+dt, -currentPoint(1, 3)+dt, int2str(landmarkIdx));
        grid on;
        hold on;
    end
    pause;
end

%%  Head Position in 3-D XYZ.
headPos1 = getHeadPosition(video1);
headPos2 = getHeadPosition(video2);

headRot1 = getHeadRotation(video1);
headRot2 = getHeadRotation(video2);

    