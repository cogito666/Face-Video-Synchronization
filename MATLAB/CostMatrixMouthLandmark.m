%% 3D Cost Matrix
clc;
clear;

%% Read CSV file that includes information about facial frames.
data1 = readtable('/home/cmlkaist/Desktop/test/reference/visual/openface/openface.csv', 'ReadRowNames', false);
data2 = readtable('/home/cmlkaist/Desktop/test/target/visual/openface/openface.csv', 'ReadRowNames', false);

%% Table to Matrix
video1 = table2array(data1);
video2 = table2array(data2);

%% Mouth Landmark Position 
mouthLandmarkPos1 = getLandmarkMouth3D(video1);
mouthLandmarkPos2 = getLandmarkMouth3D(video2);
 
%% Head Position in 3-D XYZ.
headPos1 = getHeadPosition(video1);
headPos2 = getHeadPosition(video2);

headRot1 = getHeadRotation(video1);
headRot2 = getHeadRotation(video2);

%% Mouth-landmark Lelative position (Head-movement considered)
mouthLandmarkRelativePos1 = adjustMouthPosition(mouthLandmarkPos1, headPos1, headRot1);
mouthLandmarkRelativePos2 = adjustMouthPosition(mouthLandmarkPos2, headPos2, headRot2);

%% Put in same coordination
refVideo1 = xRotateMatrix(-headRot1(1,1))*yRotateMatrix(-headRot1(1,2))*zRotateMatrix(-headRot1(1,3))*headPos1(1,:)';
refVideo2 = xRotateMatrix(-headRot2(1,1))*yRotateMatrix(-headRot2(1,2))*zRotateMatrix(-headRot2(1,3))*headPos2(1,:)';

% refVideo1 = headPos1(1,:)*zRotateMatrix(-headRot1(1,1))*yRotateMatrix(-headRot1(1,2))*xRotateMatrix(-headRot1(1,3));
% refVideo2 = headPos2(1,:)*zRotateMatrix(-headRot2(1,1))*yRotateMatrix(-headRot2(1,2))*xRotateMatrix(-headRot2(1,3));

% video1-video2
translation = refVideo1-refVideo2;
translation = translation';

% Move "mouthLandmarkRelativePos2" landmarks on video1 reference coordinate
sizeMouthLandmark = size(mouthLandmarkRelativePos2);
for i = 1 : sizeMouthLandmark(1)
    for j = 1 : sizeMouthLandmark(2)
        mouthLandmarkRelativePos2{i,j} = mouthLandmarkRelativePos2{i,j} + translation;
    end
end

%% Cose Matrix
% Those two videos' frames are differ. Number of landmarks are the same.
sizeVideo1 = size(mouthLandmarkRelativePos1);
sizeVideo2 = size(mouthLandmarkRelativePos2);

numOfFramesVideo1 = sizeVideo1(1);
numOfFramesVideo2 = sizeVideo2(1);

% 20 landmarks for mouth.
numOfLandmark = 20;

CostMatrix = zeros(numOfFramesVideo1, numOfFramesVideo2);
for firstVideoFrame = 1 : numOfFramesVideo1 
    for secondVideoFrame = 1 : numOfFramesVideo2
        
        cost = 0;
        for landmarkIdx = 1 : numOfLandmark
            cost = cost + norm(mouthLandmarkRelativePos1{firstVideoFrame, landmarkIdx}-mouthLandmarkRelativePos2{secondVideoFrame, landmarkIdx});
        end
        CostMatrix(firstVideoFrame, secondVideoFrame) = cost;
        
    end
end

%% Decaying function
% CostMatrix = exp(-0.005 * CostMatrix).^2; % Decay function

%% Plot
% figure(1)
% subplot(1, 2, 1)
% imagesc(CostMatrix)
% colorbar
% pbaspect([1 1 1])
% 
% %% Face Director (landmark approach)
% clc;
% clear all;
% 
% addpath('/home/cmlkaist/Desktop/FD_Validation/MATLAB/npy-matlab/npy-matlab')
% savepath()
% 
% cost_matrix_with_mfcc_numpy = '/home/cmlkaist/Desktop/test/result/cost_matrix_from_face_director_with_mfcc.npy';
% cost_matrix_with_mfcc = readNPY(cost_matrix_with_mfcc_numpy);
% 
% subplot(1, 2, 2)
% imagesc(cost_matrix_with_mfcc)
% colorbar
% pbaspect([1 1 1])