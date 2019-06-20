%% Video Face Replacement with Velocities of Mouth Landmarks
clc;
clear all;

%% Read & Write Numpy (.npy)
addpath('/home/cmlkaist/Desktop/FD_Validation/MATLAB/npy-matlab/npy-matlab')


%% Parse CSV
% video pair csv path
testSetVideoPairCSV= '/home/cmlkaist/Desktop/from_YJ/video_pair.csv';

% root-directory: output videos
referenceVideoDataDirectory = '/home/cmlkaist/Desktop/from_YJ/';
targetVideoDataDirectory = '/home/cmlkaist/Desktop/from_YJ/';

% output directory
outputDirectory = '/home/cmlkaist/Desktop/from_YJ/cost_matrix/';

% read test-set video pair csv
opts = detectImportOptions(testSetVideoPairCSV, 'delimiter', ',');
testSetVideoPair = readmatrix(testSetVideoPairCSV, opts);


[numberOfVideoPair, ] = size(testSetVideoPair);
for videoPairIndex = 1 : numberOfVideoPair
    
    % input
    referenceVideo = testSetVideoPair{videoPairIndex, 1};
    targetVideo = testSetVideoPair{videoPairIndex, 2};
    
    [reference_filepath,reference_name,reference_ext] = fileparts(referenceVideo);
    [target_filepath,target_name,target_ext] = fileparts(targetVideo);
    
    referenceVideoDataDirectoryCurrent = fullfile(referenceVideoDataDirectory, reference_name);
    targetVideoDataDirectoryCurrent = fullfile(targetVideoDataDirectory, target_name);
   
    % output
    outputCostMatrixNpy = [outputDirectory, strcat(sprintf('%d',videoPairIndex), '_' ,'landmark.npy')];
    
    % process: Dale et al 
    video1_openface_csv = fullfile(referenceVideoDataDirectoryCurrent, 'visual/openface/openface.csv');
    video2_openface_csv = fullfile(targetVideoDataDirectoryCurrent, 'visual/openface/openface.csv');

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
    
    % Save
    writeNPY(CostMatrix, outputCostMatrixNpy)
    
    clear CostMatrix
end
