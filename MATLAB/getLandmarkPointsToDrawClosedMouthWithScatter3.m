function [xs, ys, zs] = getLandmarkPointsToDrawClosedMouthWithScatter3(mouthLandmarks, frameIdx)
% Instead of plot every points, just make up a list that could be used with scatter3, line.
    
    [numberOfFrames, numberOfOuterMouthLandmarks] = size(mouthLandmarks);

    xs = [];
    ys = [];
    zs = [];
    for indexLandmark = 1 : numberOfOuterMouthLandmarks
        xs = [xs, mouthLandmarks{frameIdx,indexLandmark}(1)];
        ys = [ys, mouthLandmarks{frameIdx,indexLandmark}(2)];
        zs = [zs, mouthLandmarks{frameIdx,indexLandmark}(3)];
    end

    % Insdead of this 4 lines of code that is not readable, just add first points to the list
    xs = [xs, xs(1)];
    ys = [ys, ys(1)];
    zs = [zs, zs(1)];
end

