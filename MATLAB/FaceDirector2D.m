%% 2D Cost Matrix
clc;
clear;

%% Read CSV file that includes information about facial frames.
data1 = readtable('/home/cmlkaist/Desktop/test/reference/visual/openface/openface.csv', 'ReadRowNames', false);
data2 = readtable('/home/cmlkaist/Desktop/test/target/visual/openface/openface.csv', 'ReadRowNames', false);

%% Table to Matrix
video1 = table2array(data1);
video2 = table2array(data2);

%% Get Mouth Landmark Position 
mouthLandmarkPos1 = getLandmarkMouth2D(video1);
mouthLandmarkPos2 = getLandmarkMouth2D(video2);

%% Head Position in 2-D XY: Landmark 33 for facial center
faceCenter1 = getFaceCenter2D(video1);
faceCenter2 = getFaceCenter2D(video2);

%% Mouth-landmark Lelative position (Head-movement considered)
mouthLandmarkRelativePos1 = adjustMouthPosition2D(mouthLandmarkPos1, faceCenter1);
mouthLandmarkRelativePos2 = adjustMouthPosition2D(mouthLandmarkPos2, faceCenter2);

%% Put in same coordination
% Move "mouthLandmarkRelativePos2" landmarks on video1 reference coordinate
mouthLandmarkSameCoordinate1 = mouthLandmarkRelativePos1;
mouthLandmarkSameCoordinate2 = mouthLandmarkRelativePos2;
[numOfFrames, numOfLandmarks] = size(mouthLandmarkRelativePos2);

refVideo1 = faceCenter1(1,:);
refVideo2 = faceCenter2(1,:);
% video1-video2
translation = refVideo2-refVideo1;

for frameIdx = 1 : numOfFrames
    for landmarkIdx = 1 : numOfLandmarks
%         x = mouthLandmarkRelativePos2{frameIdx, landmarkIdx}(1);
%         y = mouthLandmarkRelativePos2{frameIdx, landmarkIdx}(2);
%         x
%         y
%         x = x-translation(1);
%         y = y-translation(2);
%         x
%         y
%         mouthLandmarkSameCoordinate2{frameIdx, landmarkIdx}(1) = x
%         mouthLandmarkSameCoordinate2{frameIdx, landmarkIdx}(2) = y
        mouthLandmarkSameCoordinate2{frameIdx, landmarkIdx} = mouthLandmarkRelativePos2{frameIdx, landmarkIdx} - translation;
    end
end


%% plot face landmarks per frames.
% video1_path = '/home/cmlkaist/IITP/video3rd/result/normal.avi';
% video1Reader = VideoReader(video1_path);
% % numOfFrames = video1Reader.NumberOfFrames;
% 
% lineLength = 50;
% 
% % output dir for all figures
% outDir = '/home/cmlkaist/IITP/video3rd/MATLAB landmarks overlay/';
% 
% frameIdx = 1;
% while hasFrame(video1Reader)
%     frame = readFrame(video1Reader);
%        
%     figure(frameIdx);
%     set(0,'DefaultFigureVisible','off');
%     imshow(frame);
%     
%     cx = headPos2(frameIdx, 1);
%     cy = headPos2(frameIdx, 2);
% 
%     line([cx + lineLength cx - lineLength], [cy cy], 'LineWidth', 3, 'Color', 'g');
%     line([cx cx], [cy + lineLength cy - lineLength], 'LineWidth', 3, 'Color', 'g');
% 
%     % Put All Mouth-Landmarks on face.
%     for landmarkIdx = 1 : 20
%         hold on;
%         x = mouthLandmarkRelativePos1{frameIdx, landmarkIdx}(1,1);
%         y = mouthLandmarkRelativePos1{frameIdx, landmarkIdx}(1,2);
%         plot(x, y, '-og');
%     end   
%     
%     saveas(gcf,strcat(outDir,int2str(frameIdx),'.png'));
%     
%     frameIdx = frameIdx + 1;
% end


%% Cose Matrix
% Those two videos' frames are differ. Number of landmarks are the same.
sizeVideo1 = size(mouthLandmarkSameCoordinate1);
sizeVideo2 = size(mouthLandmarkSameCoordinate2);

numOfFramesVideo1 = sizeVideo1(1);
numOfFramesVideo2 = sizeVideo2(1);

% Number of MouthLandmarks
numOfLandmark = sizeVideo1(2);

CostMatrix = zeros(numOfFramesVideo1, numOfFramesVideo2);
for firstVideoFrame = 1 : numOfFramesVideo1 
    for secondVideoFrame = 1 : numOfFramesVideo2
        
        cost = 0;
        for landmarkIdx = 1 : numOfLandmark
            cost = cost + norm(mouthLandmarkSameCoordinate1{firstVideoFrame, landmarkIdx}-mouthLandmarkSameCoordinate2{secondVideoFrame, landmarkIdx});
        end
        CostMatrix(firstVideoFrame, secondVideoFrame) = cost;
        
    end
end
%%
% CostMatrix = exp(-0.005 * CostMatrix).^2; % Decay function

colormap(flipud(gray))
imagesc(CostMatrix)
colorbar
