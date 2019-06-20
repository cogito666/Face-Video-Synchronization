%% functions to calculate cost matrix
function distance = Euclidean2D(x1, y1, x2, y2)
    fprintf('%d %d %d %d\n', x1, y1, x2, y2);
    distance = sqrt((x2-x1)^2 + (y2-y1)^2);
end