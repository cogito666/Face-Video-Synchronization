%% Video Face Replacement with Velocities of Mouth Landmarks
clc;
clear all;

%% Read & Write Numpy (.npy)
addpath('/home/cmlkaist/Desktop/FD_Validation/MATLAB/npy-matlab/npy-matlab')

%% Parse CSV

% process: Dale et al 
video1_openface_csv = '/home/cmlkaist/Desktop/NonDiagonalPath2/data/dohyeong_fast/visual/openface/openface.csv';
video2_openface_csv = '/home/cmlkaist/Desktop/NonDiagonalPath2/data/yoonjae_slow/visual/openface/openface.csv';

% output
outputDirectory = '/home/cmlkaist/Desktop/NonDiagonalPath2/result/dohyeong_fast_yoonjae_slow';
outputCostMatrixNpy = fullfile(outputDirectory, '/dale.npy');

video1DataTable = readtable(video1_openface_csv, 'ReadRowNames', false);
video2DataTable = readtable(video2_openface_csv, 'ReadRowNames', false);

video1DataArray = table2array(video1DataTable);
video2DataArray = table2array(video2DataTable);

% Parse Mouth Landmark Position 
mouthLandmarkPositionVideo1 = getLandmarkMouth3D(video1DataArray);
mouthLandmarkPositionVideo2 = getLandmarkMouth3D(video2DataArray);

% Parse Head Position and Rotation Angel
headVideo1 = getHeadPosition(video1DataArray);
headVideo2 = getHeadPosition(video2DataArray);

headRotationAngleVideo1 = getHeadRotation(video1DataArray);
headRotationAngleVideo2 = getHeadRotation(video2DataArray);

% Normalize Face
mouthLandmarkNormlizedVideo1 = normalize(mouthLandmarkPositionVideo1, headVideo1, headRotationAngleVideo1);
mouthLandmarkNormlizedVideo2 = normalize(mouthLandmarkPositionVideo2, headVideo2, headRotationAngleVideo2);

% Velocity of Mouth Landmark
velocityMouthLandmarkVideo1 = getVelocityOfLandmark(mouthLandmarkNormlizedVideo1);
velocityMouthLandmarkVideo2 = getVelocityOfLandmark(mouthLandmarkNormlizedVideo2);

% Make up Cose Matrix
[numOfFramesVideo1, numOfMouthLandmarkVideo1]= size(velocityMouthLandmarkVideo1);
[numOfFramesVideo2, numOfMouthLandmarkVideo2] = size(velocityMouthLandmarkVideo2);

% 20 landmarks for mouth.
numOfLandmark = 20;

upperLiplandmarkToUse = [14, 15, 16];
lowerLiplandmarkToUse = [18, 19, 20];

numberOfUpperLipLandmark = length(upperLiplandmarkToUse);
numberOfLowerLipLandmark = length(lowerLiplandmarkToUse);


CostMatrix = zeros(numOfFramesVideo1, numOfFramesVideo2);
for firstVideoFrame = 1 : numOfFramesVideo1 
    for secondVideoFrame = 1 : numOfFramesVideo2

        cost = 0;
        
        % upper lip
        for i = 1 : numberOfUpperLipLandmark
            min_cost = 1e9;
            for j = 1 : numberOfUpperLipLandmark
                sub_cost = norm(mouthLandmarkNormlizedVideo1{firstVideoFrame , upperLiplandmarkToUse(i)} ...
                            - mouthLandmarkNormlizedVideo2{secondVideoFrame, upperLiplandmarkToUse(j)});
                min_cost = min(min_cost, sub_cost);
            end
            cost = cost + min_cost;
            
            min_cost = 1e9;
            
            for j = 1 : numberOfUpperLipLandmark
                sub_cost = norm(mouthLandmarkNormlizedVideo1{firstVideoFrame , upperLiplandmarkToUse(i)} ...
                            - mouthLandmarkNormlizedVideo2{secondVideoFrame, upperLiplandmarkToUse(j)});
                min_cost = min(min_cost, sub_cost);
            end            
            cost = cost + min_cost;
        end
        
        % lower lip
        for i = 1 : numberOfLowerLipLandmark
            min_cost = 1e9;
            for j = 1 : numberOfLowerLipLandmark
                sub_cost = norm(mouthLandmarkNormlizedVideo1{firstVideoFrame , lowerLiplandmarkToUse(i)} ...
                            - mouthLandmarkNormlizedVideo2{secondVideoFrame, lowerLiplandmarkToUse(j)});
                min_cost = min(min_cost, sub_cost);
            end
            cost = cost + min_cost;
            
            min_cost = 1e9;
            
            for j = 1 : numberOfLowerLipLandmark
                sub_cost = norm(mouthLandmarkNormlizedVideo1{firstVideoFrame , lowerLiplandmarkToUse(i)} ...
                            - mouthLandmarkNormlizedVideo2{secondVideoFrame, lowerLiplandmarkToUse(j)});
                min_cost = min(min_cost, sub_cost);
            end            
            cost = cost + min_cost;
        end
        
        CostMatrix(firstVideoFrame, secondVideoFrame) = cost;

    end
end

% Save
writeNPY(CostMatrix, outputCostMatrixNpy)


% Plot Cost-Matrix
figure(1)

% left: cost-matrix only
subplot(1, 2, 1)
imagesc(CostMatrix)
colorbar
pbaspect([1 1 1])

% right: cost-matrix with sync-path
subplot(1, 2, 2)
imagesc(CostMatrix)
colorbar
pbaspect([1 1 1])
hold on
[targetVideoFrameIdx,referenceVideoFrameIdx,C] = dp(CostMatrix);
plot(referenceVideoFrameIdx, targetVideoFrameIdx, 'color', 'r')
