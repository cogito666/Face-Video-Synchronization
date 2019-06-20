function [xpos, ypos] = getLandmarkTotal(data)
    % 2D facial landmark position
    % x_0 ~ x_67:(index) 300 ~ 367    
    % y_0 ~ y_67:(index) 368 ~ 435
    xpos = data(1: end, 300:367);
    ypos = data(1: end, 368:435);

    xpos = table2array(xpos);
    ypos = table2array(ypos);
end