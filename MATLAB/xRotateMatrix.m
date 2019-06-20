%% Rotation X-axis left-handed coordinste system
% theta unit: radian
function Rx = xRotateMatrix(theta)
    
    
    Rx = [1 0 0;...
          0 cos(theta) sin(theta);...
          0 -sin(theta) cos(theta)];

end