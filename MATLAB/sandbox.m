%% sandbox
clc;
clear all;

%% Parse CSV
testSetVideoPairCSV = '/home/cmlkaist/Desktop/UserStudyVideo_v2/user_study_video_pair.csv';

opts= detectImportOptions(testSetVideoPairCSV, 'delimiter', ',');
readmatrix(testSetVideoPairCSV, opts)
