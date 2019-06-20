%% Rotation Z-axis left-handed coordinste system
% theta unit: radian
function Rz = zRotateMatrix(theta)
    
    Rz = [cos(theta) sin(theta) 0;...
          -sin(theta) cos(theta) 0;...
          0 0 1];

end