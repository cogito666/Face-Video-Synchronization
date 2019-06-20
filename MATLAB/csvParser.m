%%
clc;
clear;

%% facial landmark position (Mouth) extraction output csv parser (OpenFace)
data1 = readtable('/home/cmlkaist/IITP/video2nd/result/Speech3-1.csv', 'ReadRowNames', false);
data2 = readtable('/home/cmlkaist/IITP/video2nd/result/Speech3-2.csv', 'ReadRowNames', false);
% data3 = readtable('/home/cmlkaist/IITP/video2nd/result/Part3.csv', 'ReadRowNames', false);

[xpos1, ypos1] = getLandmarkMouth(data1);
[xpos2, ypos2] = getLandmarkMouth(data2);
% [xpos3, ypos3] = getLandmarkMouth(data3);

%% Euclidean Distance Between Each Frame
distance1 = distanceBetweenFrames(xpos1, ypos1);
distance2 = distanceBetweenFrames(xpos2, ypos2);
% distance3 = distanceBetweenFrames(xpos3, ypos3);

%% Cose Matrix

len1 = length(distance1);
len2 = length(distance2);
% len3 = length(distance3);

costMatrix1And2 = zeros(len1, len2);
for row = 1 : len1 
    for col = 1 : len2
        costMatrix1And2(row, col) = abs(distance1(row)-distance2(col));
    end
end
%%
imagesc(costMatrix1And2)
colormap('jet')
colorbar
