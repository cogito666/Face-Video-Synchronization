%% functions to calculate cost matrix
function distance = Euclidean3D(x1, y1, z1, x2, y2, z2)
    distance = sqrt((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2);
end