%% function to set axis limit according to it's data to be shown.

% xValues: Matrix including all the positions of points in X axis.
% yValues: Matrix including all the positions of points in Y axis.

function limitAxis(xValues, yValues)
    minX = min(xValues(:));
    maxX = max(xValues(:));
    
    minY = min(yValues(:));
    maxY = max(yValues(:));
    
    % debug
    fprintf('%d %d %d %d\n', minX, maxX, minY, maxY);
    
    axis([minX, maxX, minY, maxY]);
end