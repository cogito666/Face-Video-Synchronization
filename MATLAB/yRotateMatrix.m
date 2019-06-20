%% Rotation Y-axis left-handed coordinste system
% theta unit: radian
function Ry = yRotateMatrix(theta)
    
    Ry = [cos(theta) 0 -sin(theta);...
          0 1 0;...
          sin(theta) 0 cos(theta)];

end