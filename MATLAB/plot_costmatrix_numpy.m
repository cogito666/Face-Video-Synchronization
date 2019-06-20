%% Face Director (landmark approach)
clc;
clear all;

%%
addpath('/home/cmlkaist/Desktop/FD_Validation/MATLAB/npy-matlab/npy-matlab')
savepath()
% ls '/home/cmlkaist/Desktop/FD_Validation/MATLAB/npy-matlab/npy-matlab'

%%
cost_matrix_with_mfcc_numpy = '/home/cmlkaist/Desktop/test/result/cost_matrix_from_face_director_with_mfcc.npy';
cost_matrix_with_mfcc = readNPY(cost_matrix_with_mfcc_numpy);

figure(1)
imagesc(cost_matrix_with_mfcc)
colorbar