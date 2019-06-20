%% Code Validation of Face-Director with 3D facial landmark
% final goal is to see landmarks of two different videos are show up close.
clc;
clear;

%%
framePairToPlot = [197, 197];
frameToSeeVideo1 = framePairToPlot(1);
frameToSeeVideo2 = framePairToPlot(2);

%% Read CSV file that includes information about facial frames.
video1DataTable = readtable('/home/cmlkaist/Dohyeong/video_synchronization/video/actor_23_ref_video/visual/openface/openface.csv', 'ReadRowNames', false);
video2DataTable = readtable('/home/cmlkaist/Dohyeong/video_synchronization/video/actor_24_tgt_video/visual/openface/openface.csv', 'ReadRowNames', false);

outputCostMatrixNumpy = '/home/cmlkaist/Dohyeong/video_synchronization/video/ravdess_result/cost_matrix_landmark.npy';

%% Table to Matrix
video1DataArray = table2array(video1DataTable);
video2DataArray = table2array(video2DataTable);

%% Get Mouth Landmark Position 
mouthLandmarkPositionVideo1 = getLandmarkMouth3D(video1DataArray);
mouthLandmarkPositionVideo2 = getLandmarkMouth3D(video2DataArray);

%% Get Every Frames' Outer ~ Inner Mouth Landmarks
outerMouthLandmarkVideo1 = mouthLandmarkPositionVideo1(:, 1:12);
innerMouthLandmarkVideo1 = mouthLandmarkPositionVideo1(:, 13:end);

outerMouthLandmarkVideo2 = mouthLandmarkPositionVideo2(:, 1:12);
innerMouthLandmarkVideo2 = mouthLandmarkPositionVideo2(:, 13:end);

%% Video 1: Before normalization
% [numberOfFrames, numberOfOuterMouthLandmarks] = size(outerMouthLandmarkVideo1);
%    
% for frameIdx = 1 : numberOfFrames
%     % Get Nth Frame's Outer ~ Inner Mouth Landmarks in the format of xs, ys, zx for scatter3 to plot
%     [xsOuterMouthLandmarkVideo1, ysOuterMouthLandmarkVideo1, zsOuterMouthLandmarkVideo1] = ...
%     getLandmarkPointsToDrawClosedMouthWithScatter3(outerMouthLandmarkVideo1, frameIdx);
%     [xsInnerMouthLandmarkVideo1, ysInnerMouthLandmarkVideo1, zsInnerMouthLandmarkVideo1] = ...
%     getLandmarkPointsToDrawClosedMouthWithScatter3(innerMouthLandmarkVideo1, frameIdx);
% 
%     % Draw Outer Mouth Landmarks
%     figure(1)
%     scatter3(xsOuterMouthLandmarkVideo1, ysOuterMouthLandmarkVideo1, zsOuterMouthLandmarkVideo1)
%     line(xsOuterMouthLandmarkVideo1, ysOuterMouthLandmarkVideo1, zsOuterMouthLandmarkVideo1)
%     hold on
% 
%     % Draw Inner Mouth Landmarks
%     scatter3(xsInnerMouthLandmarkVideo1, ysInnerMouthLandmarkVideo1, zsInnerMouthLandmarkVideo1)
%     line(xsInnerMouthLandmarkVideo1, ysInnerMouthLandmarkVideo1, zsInnerMouthLandmarkVideo1)
%    
% end

%% Parse Head Position of Each Frame in 3-D World Coordination.
headVideo1 = getHeadPosition(video1DataArray);
headVideo2 = getHeadPosition(video2DataArray);

headRotationAngleVideo1 = getHeadRotation(video1DataArray);
headRotationAngleVideo2 = getHeadRotation(video2DataArray);

%% Mouth-landmark Lelative position (Head-movement considered)
mouthLandmarkNormlizedVideo1 = normalize(mouthLandmarkPositionVideo1, headVideo1, headRotationAngleVideo1);
mouthLandmarkNormlizedVideo2 = normalize(mouthLandmarkPositionVideo2, headVideo2, headRotationAngleVideo2);


%% Make Z-value into Zero
% [numOfFramesVideo1, numOfLandmarksVideo1] = size(mouthLandmarkNormlizedVideo1);
% [numOfFramesVideo2, numOfLandmarksVideo2] = size(mouthLandmarkNormlizedVideo2);
% 
% for frameIdx = 1: numOfFramesVideo1
%    
%     for landmarkIdx = 1 : numOfLandmarksVideo1
%         mouthLandmarkNormlizedVideo1{frameIdx, landmarkIdx}(3) = 0;
%     end
% end
% 
% for frameIdx = 1: numOfFramesVideo2
%    
%     for landmarkIdx = 1 : numOfLandmarksVideo2
%         mouthLandmarkNormlizedVideo2{frameIdx, landmarkIdx}(3) = 0;
%     end
% end

%% Get Every Frames' Outer ~ InmouthLandmarkPosner Mouth Landmarks
outerMouthLandmarkNormlizedVideo1 = mouthLandmarkNormlizedVideo1(:, 1:12);
innerMouthLandmarkNormlizedVideo1 = mouthLandmarkNormlizedVideo1(:, 13:end);

outerMouthLandmarkNormlizedVideo2 = mouthLandmarkNormlizedVideo2(:, 1:12);
innerMouthLandmarkNormlizedVideo2 = mouthLandmarkNormlizedVideo2(:, 13:end);


%% Video 1: After normalization
% % 
% [numberOfFrames, numberOfOuterMouthLandmarks] = size(outerMouthLandmarkVideo1);
% % 
% figure(1)
% % % subplot(1, 2, 1)
% % 
% for frameIdx = 1 : numberOfFrames
%     if frameIdx == frameToSeeVideo1
%         % Get Nth Frame's Outer ~ Inner Mouth Landmarks in the format of xs, ys, zx for scatter3 to plot
%         [xsOuterMouthLandmarkVideo1, ysOuterMouthLandmarkVideo1, zsOuterMouthLandmarkVideo1] = ...
%         getLandmarkPointsToDrawClosedMouthWithScatter3(outerMouthLandmarkNormlizedVideo1, frameIdx);
%         [xsInnerMouthLandmarkVideo1, ysInnerMouthLandmarkVideo1, zsInnerMouthLandmarkVideo1] = ...
%         getLandmarkPointsToDrawClosedMouthWithScatter3(innerMouthLandmarkNormlizedVideo1, frameIdx);
% 
%         % Draw Outer Mouth Landmarks
%         scatter3(xsOuterMouthLandmarkVideo1, ysOuterMouthLandmarkVideo1, zsOuterMouthLandmarkVideo1)
%         line(xsOuterMouthLandmarkVideo1, ysOuterMouthLandmarkVideo1, zsOuterMouthLandmarkVideo1)
%         hold on
% 
%         % Draw Inner Mouth Landmarks
%         scatter3(xsInnerMouthLandmarkVideo1, ysInnerMouthLandmarkVideo1, zsInnerMouthLandmarkVideo1)
%         line(xsInnerMouthLandmarkVideo1, ysInnerMouthLandmarkVideo1, zsInnerMouthLandmarkVideo1)
%         hold on
%     end
%     
%     % every 30 frame erase
% %     if rem(frameIdx, 30) ~= 0
% %         hold on
% %     else
% %         hold off
% %     end
%     
% 
% %   quit after first 20 frames
% %     if frameIdx > 100
% %         break
% %     end
% 
% end

%% Video 2: After normalization
% [numberOfFrames, numberOfOuterMouthLandmarks] = size(outerMouthLandmarkVideo2);
% 
% % subplot(1, 2, 2)    
% for frameIdx = 1 : numberOfFrames
%     if frameIdx == frameToSeeVideo2
%         % Get Nth Frame's Outer ~ Inner Mouth Landmarks in the format of xs, ys, zx for scatter3 to plot
%         [xsOuterMouthLandmarkVideo2, ysOuterMouthLandmarkVideo2, zsOuterMouthLandmarkVideo2] = ...
%         getLandmarkPointsToDrawClosedMouthWithScatter3(outerMouthLandmarkNormlizedVideo2, frameIdx);
%         [xsInnerMouthLandmarkVideo2, ysInnerMouthLandmarkVideo2, zsInnerMouthLandmarkVideo2] = ...
%         getLandmarkPointsToDrawClosedMouthWithScatter3(innerMouthLandmarkNormlizedVideo2, frameIdx);
% 
%         % Draw Outer Mouth Landmarks
%         scatter3(xsOuterMouthLandmarkVideo2, ysOuterMouthLandmarkVideo2, zsOuterMouthLandmarkVideo2)
%         line(xsOuterMouthLandmarkVideo2, ysOuterMouthLandmarkVideo2, zsOuterMouthLandmarkVideo2, 'color', 'r')
%         hold on
% 
%         % Draw Inner Mouth Landmarks
%         scatter3(xsInnerMouthLandmarkVideo2, ysInnerMouthLandmarkVideo2, zsInnerMouthLandmarkVideo2)
%         line(xsInnerMouthLandmarkVideo2, ysInnerMouthLandmarkVideo2, zsInnerMouthLandmarkVideo2, 'color','r')
%         hold on
%     end
% 
% end



%% Cose Matrix
% Those two videos' frames are differ. Number of landmarks are the same.
[numOfFramesVideo1, numOfMouthLandmarkVideo1]= size(mouthLandmarkNormlizedVideo1);
[numOfFramesVideo2, numOfMouthLandmarkVideo2] = size(mouthLandmarkNormlizedVideo2);

% 20 landmarks for mouth.
numOfLandmark = 20;
landmarkToUse = [3, 4, 5, 6, 8, 9, 10, 11, 12];
% landmarkToUse = [2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 14, 15, 16, 18, 19, 20];


CostMatrix = zeros(numOfFramesVideo2, numOfFramesVideo1);
for firstVideoFrame = 1 : numOfFramesVideo1 
    for secondVideoFrame = 1 : numOfFramesVideo2
        
        cost = 0;
        % all landmark
        for landmarkIdx = 1 : numOfLandmark               
            cost = cost ...
                   + norm(mouthLandmarkNormlizedVideo1{firstVideoFrame, landmarkIdx} ...
                   - mouthLandmarkNormlizedVideo2{secondVideoFrame, landmarkIdx});
        end
        
%         for landmarkIdx = 1 : length(landmarkToUse)
%             cost = cost ...
%                     + norm(mouthLandmarkNormlizedVideo1{firstVideoFrame, landmarkToUse(landmarkIdx)}...
%                     - mouthLandmarkNormlizedVideo2{secondVideoFrame, landmarkToUse(landmarkIdx)});
%         end
        CostMatrix(secondVideoFrame, firstVideoFrame) = cost;
        
    end
end

%% Decaying function
% CostMatrix = exp(-0.005 * CostMatrix).^2; % Decay function

% Plot: Cost Matrix 
figure(3)
% subplot(1, 2, 1)
imagesc(CostMatrix)
colorbar
pbaspect([1 1 1])
% hold on
% 
% [targetVideoFrameIdx,referenceVideoFrameIdx,C] = dp(CostMatrix);
% plot(referenceVideoFrameIdx, targetVideoFrameIdx, 'color', 'r')

%%
addpath('/home/cmlkaist/Desktop/FD_Validation/MATLAB/npy-matlab/npy-matlab')
% savepath()

%% MFCC Cost-Matrix
% cost_matrix_with_mfcc_numpy = '/home/cmlkaist/Desktop/test/angry_target/cost_matrix_from_face_director_with_mfcc.npy';
% cost_matrix_with_mfcc = readNPY(cost_matrix_with_mfcc_numpy);
% 
% subplot(1, 2, 2)
% imagesc(cost_matrix_with_mfcc)
% colorbar
% pbaspect([1 1 1])
% hold on
% 
% [targetVideoFrameIdx,referenceVideoFrameIdx,C] = dp(cost_matrix_with_mfcc);
% plot(referenceVideoFrameIdx, targetVideoFrameIdx, 'color', 'r')


%%
writeNPY(CostMatrix, outputCostMatrixNumpy)

