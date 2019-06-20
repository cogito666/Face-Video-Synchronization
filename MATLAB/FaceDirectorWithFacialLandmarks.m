%% Face Director with Facial Landmarks
clc;
clear all;

%% Read & Write Numpy (.npy)
addpath('/home/cmlkaist/Desktop/FD_Validation/MATLAB/npy-matlab/npy-matlab')


%% Parse CSV
testSetVideoPairCSV= '/home/cmlkaist/Desktop/UserStudyVideo_v2/user_study_video_pair.csv';

% read csv
opts= detectImportOptions(testSetVideoPairCSV, 'delimiter', ',');
testSetVideoPair = readmatrix(testSetVideoPairCSV, opts);

% root-directory: output videos
videoDataPreprocessDirectory = '/home/cmlkaist/Desktop/UserStudyVideo_v2/';

[numberOfVideoPair, ] = size(testSetVideoPair);
for videoPairIndex = 1 : numberOfVideoPair
    % input
    referenceVideo = testSetVideoPair{videoPairIndex, 1};
    targetVideo = testSetVideoPair{videoPairIndex, 2};

    [reference_filepath,reference_name,reference_ext] = fileparts(referenceVideo);
    [target_filepath,target_name,target_ext] = fileparts(targetVideo);

    referenceVideoDataDirectory = [videoDataPreprocessDirectory, reference_name];
    targetVideoDataDirectory = [videoDataPreprocessDirectory, target_name];

    % output
    outputDirectory = ['/home/cmlkaist/Desktop/UserStudyVideo_v2/Bubbing_Video/', sprintf('%d',videoPairIndex)];
    outputCostMatrixNpy = [outputDirectory, '/FD_landmark.npy'];

    % process: Dale et al 
    video1_openface_csv = fullfile(referenceVideoDataDirectory, 'visual/openface/openface.csv')
    video2_openface_csv = fullfile(targetVideoDataDirectory, 'visual/openface/openface.csv')

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

    % Make up Cose Matrix
    [numOfFramesVideo1, numOfMouthLandmarkVideo1]= size(mouthLandmarkNormlizedVideo1);
    [numOfFramesVideo2, numOfMouthLandmarkVideo2] = size(mouthLandmarkNormlizedVideo2);

    % 20 landmarks for mouth.
    numOfLandmark = 20;

    CostMatrix = zeros(numOfFramesVideo1, numOfFramesVideo2);
    for firstVideoFrame = 1 : numOfFramesVideo1 
        for secondVideoFrame = 1 : numOfFramesVideo2

            % All mouth landmarks
            cost = 0;
            for landmarkIdx = 1 : numOfLandmark               
                cost = cost ...
                       + norm(mouthLandmarkNormlizedVideo1{firstVideoFrame, landmarkIdx} ...
                       - mouthLandmarkNormlizedVideo2{secondVideoFrame, landmarkIdx});
            end
            CostMatrix(firstVideoFrame, secondVideoFrame) = cost;

        end
    end

%     % Plot Cost-Matrix
%     figure(1)
% 
%     % left: cost-matrix only
%     subplot(1, 2, 1)
%     imagesc(CostMatrix)
%     colorbar
%     pbaspect([1 1 1])
% 
%     % right: cost-matrix with sync-path
%     subplot(1, 2, 2)
%     imagesc(CostMatrix)
%     colorbar
%     pbaspect([1 1 1])
%     hold on
%     [targetVideoFrameIdx,referenceVideoFrameIdx,C] = dp(CostMatrix);
%     plot(referenceVideoFrameIdx, targetVideoFrameIdx, 'color', 'r')

    % Save
    writeNPY(CostMatrix, outputCostMatrixNpy)

    % delete in Workspace (memory)
    clear CostMatrix
end

