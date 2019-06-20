%% Plot face with given 'dt'
function facialLandmarkAnimate(xpos, ypos, dt)
    [numOfFrames, numOfLandmarks] = size(xpos);
    timeInterval = dt;
%     limitAxis(xpos, ypos);
%     axis manual;

    for i = 1 : numOfFrames
        clf();
        for j = 1: numOfLandmarks
            plot(xpos(i,j), ypos(i,j), '-o');
            hold on;
        end
        pause(timeInterval);
    end
end
