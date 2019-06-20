%% cost matrix comparision
clear all;
clc;

%% file path
cost_matrix_left_file = '/home/cmlkaist/Desktop/from_YJ/noise_noise/original.npy';
cost_matrix_right_file = '/home/cmlkaist/Desktop/from_YJ/noise_noise/sound_noise.npy';


%% MFCC Cost-Matrix
cost_matrix_left = readNPY(cost_matrix_left_file);
cost_matrix_right = readNPY(cost_matrix_right_file);


[costMatrixLeftTargetVideoFrameIdx,costMatrixLeftReferenceVideoFrameIdx,C] = dp(cost_matrix_left);
[costMatrixRightTargetVideoFrameIdx,costMatrixRightReferenceVideoFrameIdx,C] = dp(cost_matrix_right);
%% left
subplot(2, 2, 1)
imagesc(cost_matrix_left)
colorbar
pbaspect([1 1 1])

%% left with path
subplot(2, 2, 3)
imagesc(cost_matrix_left)
colorbar
pbaspect([1 1 1])
hold on
plot(costMatrixLeftReferenceVideoFrameIdx, costMatrixLeftTargetVideoFrameIdx, 'color', 'r')

%% right
subplot(2, 2, 2)
imagesc(cost_matrix_right)
colorbar
pbaspect([1 1 1])

%% 
subplot(2, 2, 4)
imagesc(cost_matrix_right)
colorbar
pbaspect([1 1 1])
hold on

plot(costMatrixRightReferenceVideoFrameIdx, costMatrixRightTargetVideoFrameIdx, 'color', 'r')
pbaspect([1 1 1])

